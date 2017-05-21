using SENB_ENB_Manager.Properties;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using Newtonsoft.Json.Linq;

namespace SENB_ENB_Manager.Model
{
    public class PresetManager
    {
        public static void SavePreset(string presetName, string presetDescription)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var presetLocation = Path.Combine(metaLocation, Settings.Default.PresetDirectory, presetName);
            var enbFilterLocation = Path.Combine(metaLocation, Settings.Default.FilterLocation);
            var gameDirectory = GetSettings.Return(SettingTypes.GameLocation);
            var filteredFiles = new List<string>();
            var filteredDirectories = new List<string>();

            // Check to see if the presetDirectory exists. If it does, delete it and create a new one.
            if (Directory.Exists(presetLocation))
            {
                DeleteDirectory(presetLocation);
            }

            while (!Directory.Exists(presetLocation))
            {
                Directory.CreateDirectory(presetLocation);
            }


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

            // Copy all of the files
            filteredFiles.ForEach(x => FileCopyTo(x, presetLocation));
            filteredDirectories.ForEach(x => DirCopyTo(x, presetLocation));

            // Create a JSON file containing the description and ENB binary version
            var metaFileLocation = Path.Combine(presetLocation, "meta.ini");
            File.Create(metaFileLocation).Dispose();
            File.WriteAllText(metaFileLocation, presetDescription);
        }

        private static void FileCopyTo(string source, string destination)
        {
            File.Move(source, Path.Combine(destination, new FileInfo(source).Name));
        }

        private static void DirCopyTo(string source, string destination)
        {
            var destinationDirectory = Path.Combine(destination, new DirectoryInfo(source).Name);
            Directory.Move(source, destinationDirectory);
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
