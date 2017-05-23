using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SENB_ENB_Manager.Properties;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace SENB_ENB_Manager.Model
{
    public class PresetManager
    {
        public static void SavePreset(string presetName, string presetDescription, bool usingGlobalIni)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var presetLocation = Path.Combine(metaLocation, Settings.Default.PresetDirectory, presetName);
            var enbFilterLocation = Path.Combine(metaLocation, Settings.Default.FilterLocation);
            var gameDirectory = GetSettings.Return(SettingTypes.GameLocation);
            var globalIniLocation = Path.Combine(metaLocation, Settings.Default.GlobalIniLocation);
            var filteredFiles = new List<string>();
            var filteredDirectories = new List<string>();
            var binaryVersion = "";

            // Check to see if the presetDirectory exists. If it does, delete it and create a new one.
            if (Directory.Exists(presetLocation)) DeleteDirectory(presetLocation);

            while (!Directory.Exists(presetLocation)) Directory.CreateDirectory(presetLocation);

            // Get the list of enbFilters
            var enbFilter = File.ReadAllLines(enbFilterLocation);

            foreach (var filter in enbFilter)
            {
                if (File.Exists(Path.Combine(gameDirectory, filter)))
                {
                    Debug.WriteLine($"File found: {filter}");
                    filteredFiles.Add(Path.Combine(gameDirectory, filter));
                }

                if (Directory.Exists(Path.Combine(gameDirectory, filter)))
                {
                    Debug.WriteLine($"Directory found: {filter}");
                    filteredDirectories.Add(Path.Combine(gameDirectory, filter));
                }
            }

            // Move all of the files
            filteredFiles.ForEach(x => File.Move(x, Path.Combine(presetLocation, new FileInfo(x).Name)));
            filteredDirectories.ForEach(x => DirMoveTo(x, presetLocation));

            // If the global ini is enabled, move that into the preset directory.
            if (usingGlobalIni)
            {
                var enblocalLocation = Path.Combine(presetLocation, "enblocal.ini");

                if (File.Exists(enblocalLocation))
                    File.Delete(enblocalLocation);

                File.Copy(globalIniLocation, enblocalLocation);
            }

            // Check for a binary version, and identify the version.
            foreach (var file in filteredFiles)
            {
                if (new FileInfo(file).Name != "d3d9.dll") continue;
                var tempFilePath = Path.Combine(presetLocation, new FileInfo(file).Name);
                binaryVersion = new BinaryManager().GetBinaryVersion(tempFilePath);
            }

            // Create a JSON file containing the description and ENB binary version
            var metaFileLocation = Path.Combine(presetLocation, "meta.ini");
            File.Create(metaFileLocation).Dispose();
            var jsonObject = new JObject()
            {
                new JProperty("Description", presetDescription),
                new JProperty("BinaryVersion", binaryVersion)
            };

            using (var file = File.CreateText(metaFileLocation))
            using (var writer = new JsonTextWriter(file))
            {
                jsonObject.WriteTo(writer);
            }
        }

        public static List<PresetData> GetPresets()
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var presetsDirectory = Path.Combine(metaLocation, Settings.Default.PresetDirectory);
            var directories = Directory.GetDirectories(presetsDirectory).OrderBy(d => new FileInfo(d).CreationTime);
            var presetsList = new List<PresetData>();

            foreach (var dir in directories)
            {
                var presetName = new DirectoryInfo(dir).Name;
                var metaFileContents = File.ReadAllText(Path.Combine(presetsDirectory, presetName, "meta.ini"));
                var jsonObject = JObject.Parse(metaFileContents);
                var presetDescription = (string)jsonObject["Description"];
                var binaryVersion = (string)jsonObject["BinaryVersion"];
                var isInstalled = false;
                var iconType = "Download";

                if (binaryVersion == "")
                    binaryVersion = "None";

                if (presetName == GetSettings.Return(SettingTypes.InstalledPreset))
                {
                    isInstalled = true;
                    iconType = "FileRestore";
                }

                presetsList.Add(new PresetData()
                {
                    Name = presetName,
                    Description = presetDescription,
                    IsInstalled = isInstalled,
                    BinaryVersion = binaryVersion,
                    IconType = iconType
                });
            }

            return presetsList.OrderByDescending(x => x.IsInstalled).ToList();
        }

        public static void InstallPreset(string presetName)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var gameDirectory = GetSettings.Return(SettingTypes.GameLocation);
            var presetLocation = Path.Combine(metaLocation, Settings.Default.PresetDirectory, presetName);
            var filterList = File.ReadLines(Path.Combine(metaLocation, Settings.Default.FilterLocation));
            var presetFiles = Directory.GetFiles(presetLocation).Where(x => new FileInfo(x).Name != "meta.ini").ToList();
            var presetDirectories = Directory.GetDirectories(presetLocation).ToList();

            // Clean the game directory of all existing files.
            foreach (var item in filterList)
            {
                var tempPath = Path.Combine(gameDirectory, item);

                if (File.Exists(tempPath))
                {
                    File.Delete(tempPath);
                }

                if (Directory.Exists(tempPath))
                {
                    Directory.Delete(tempPath, true);
                }
            }

            // Copy the selected files into the game directory.
            presetFiles.ForEach(x => File.Copy(x, Path.Combine(gameDirectory, new FileInfo(x).Name)));
            presetDirectories.ForEach(x => DirCopyTo(x, Path.Combine(gameDirectory, new DirectoryInfo(x).Name)));

            // Finally, save the preset.
            SaveSettings.Save(SettingTypes.InstalledPreset, presetName);
        }

        public static string GetBinaryVersion(string presetName)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var presetLocation = Path.Combine(metaLocation, Settings.Default.PresetDirectory, presetName);
            var metaFileLocation = Path.Combine(presetLocation, "meta.ini");

            var jsonObject = JObject.Parse(File.ReadAllText(metaFileLocation));
            var result = (string)jsonObject["BinaryVersion"];

            if (result == "")
                result = "None";

            return result;
        }

        public static void UninstallPreset(string presetName)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var presetLocation = Path.Combine(metaLocation, Settings.Default.PresetDirectory, presetName);

            // Delete the directory the preset is located in
            DeleteDirectory(presetLocation);

            // Check to see if the END is set to be currently installed. If it is, remove it from the settings.
            if (presetName == GetSettings.Return(SettingTypes.InstalledPreset))
            {
                // Clean the game directory
                CleanGameDirectory();
                SaveSettings.Save(SettingTypes.InstalledPreset, "");
            }
        }

        public static void CleanGameDirectory(bool removeSettingsValue = false)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var filterList = File.ReadLines(Path.Combine(metaLocation, Settings.Default.FilterLocation));
            var gameDirectory = GetSettings.Return(SettingTypes.GameLocation);

            foreach (var item in filterList)
            {
                var tempPath = Path.Combine(gameDirectory, item);

                if (File.Exists(tempPath))
                {
                    File.Delete(tempPath);
                }

                if (Directory.Exists(tempPath))
                {
                    Directory.Delete(tempPath, true);
                }
            }

            if (removeSettingsValue)
            {
                SaveSettings.Save(SettingTypes.InstalledPreset, "");
            }
        }

        private static void DirMoveTo(string source, string destination)
        {
            var destinationDirectory = Path.Combine(destination, new DirectoryInfo(source).Name);
            Directory.Move(source, destinationDirectory);
        }

        private static void DirCopyTo(string source, string destination)
        {
            new Microsoft.VisualBasic.Devices.Computer().FileSystem.CopyDirectory(source, destination);
        }

        private static void DeleteDirectory(string path)
        {
            foreach (string directory in Directory.GetDirectories(path))
            {
                DeleteDirectory(directory);
            }

            try
            {
                Directory.Delete(path, true);
            }
            catch (IOException)
            {
                Directory.Delete(path, true);
            }
            catch (UnauthorizedAccessException)
            {
                Directory.Delete(path, true);
            }
        }
    }
}