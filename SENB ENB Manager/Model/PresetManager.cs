using SENB_ENB_Manager.Classes;
using SENB_ENB_Manager.Properties;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SENB_ENB_Manager.Model
{
    class PresetManager
    {
        public void AddPreset(Preset preset)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var presetInfoFile = Settings.Default.PresetInfoFile;
            var tempDirectory = Path.Combine(metaLocation, Settings.Default.TempDirectory);
            var basePresetDirectory = Path.Combine(metaLocation, Settings.Default.PresetDirectory);
            var presetDirectory = Path.Combine(metaLocation, Settings.Default.PresetDirectory);

            // Note, notify user that current preset will be deleted.
            if (File.Exists(presetDirectory))
                Directory.Delete(presetDirectory, true);

            if (File.Exists(tempDirectory))
                Directory.Delete(tempDirectory);

            Directory.CreateDirectory(presetDirectory);
            Directory.CreateDirectory(tempDirectory);

            File.Create(Path.Combine(presetDirectory, presetInfoFile));

            // Make a map of all files in the ~temp location
            var TreeMap = new DirectoryMap(tempDirectory);
            
            // Move all of the files from temp to this file


        }
    }
}
