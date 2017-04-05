using SENB_ENB_Manager.Properties;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SENB_ENB_Manager.Domain
{
    class PresetManager
    {
        public void AddPreset(string presetName, string presetDescription)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var basePresetDirectory = Path.Combine(metaLocation, Settings.Default.PresetDirectory);
            var presetDirectory = Path.Combine(metaLocation, Settings.Default.PresetDirectory, presetName);

            if (!File.Exists(presetDirectory))
                File.Create(presetDirectory);

            

        }
    }
}
