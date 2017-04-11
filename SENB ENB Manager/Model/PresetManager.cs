using SENB_ENB_Manager.Classes;
using SENB_ENB_Manager.Properties;
using System;
using System.Collections.Generic;
using System.IO;

namespace SENB_ENB_Manager.Model
{
    class PresetManager
    {
        public void SavePreset(Preset preset)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var presetInfoFile = Settings.Default.PresetInfoFile;
            var basePresetDirectory = Path.Combine(metaLocation, Settings.Default.PresetDirectory);
            var presetDirectory = Path.Combine(metaLocation, Settings.Default.PresetDirectory);

            // Note, notify user that current preset will be deleted.
            if (File.Exists(presetDirectory))
                Directory.Delete(presetDirectory, true);

            Directory.CreateDirectory(presetDirectory);

            File.Create(Path.Combine(presetDirectory, presetInfoFile));
            
            // Save a list of all selected file paths.




        }
    }
}
