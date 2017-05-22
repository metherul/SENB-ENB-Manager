using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SENB_ENB_Manager.Properties;

namespace SENB_ENB_Manager.Model
{
    public class ApplicationContinuity
    {
        public static List<string> VerifyAll()
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var dataDirectory = Path.Combine(metaLocation, "data");
            var settingsLocation = Path.Combine(metaLocation, Settings.Default.SettingsLocation);
            var globalEnbIniLocation = Path.Combine(metaLocation, Settings.Default.GlobalIniLocation);
            var filterLocation = Path.Combine(metaLocation, Settings.Default.FilterLocation);
            var presetLocation = Path.Combine(metaLocation, Settings.Default.PresetDirectory);
            var missingFiles = new List<string>();

            if (!Directory.Exists(dataDirectory))
            {
                missingFiles.Add(dataDirectory);
                Directory.CreateDirectory(dataDirectory);
            }

            if (!File.Exists(settingsLocation))
            {
                missingFiles.Add(settingsLocation);

                // Create the missing settings file, fill with needed JSON data.
                File.Create(settingsLocation).Dispose();
                var jsonObject = new JObject()
                {
                    new JProperty("GameLocation", ""),
                    new JProperty("InstalledPreset", "")
                };

                using (var file = File.CreateText(settingsLocation))
                using (var writer = new JsonTextWriter(file))
                {
                    jsonObject.WriteTo(writer);
                }
            }

            if (!File.Exists(globalEnbIniLocation))
            {
                missingFiles.Add(globalEnbIniLocation);

                File.Create(globalEnbIniLocation).Dispose();
            }

            if (!File.Exists(filterLocation))
            {
                // This is a big deal, notify the user asap.
                missingFiles.Add(filterLocation);
            }

            if (!Directory.Exists(presetLocation))
            {
                missingFiles.Add(presetLocation);

                Directory.CreateDirectory(presetLocation);
            }

            return missingFiles;
        }
    }
}
