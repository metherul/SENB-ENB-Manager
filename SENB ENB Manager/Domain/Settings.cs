using SENB_ENB_Manager.Properties;
using System;
using System.IO;

namespace SENB_ENB_Manager.Domain
{
    // Get all settings from the settings.json file. Serialization should be easy.
    // It's 5:00 AM here, I don't know what I'm doing. Somehow these comments help me look back and laugh at how good my code is when I'm tired.
    // Why am I using json instead of just using the settings.settings that would make things 100x easier? I'm bored. I need a challenge or something stupid like that.
    // Maybe I'm just a moron, I dunno.
    // Lol looking back at this code I'm just going to use the WPF settings. It's easy, and I'm a lazy, tired guy.
    public class SaveSettings
    {
        public static void Save(SettingTypes settingType, object contents)
        {
            // To make it even more complex, lets do this.
            // GameLocation - string
            // IsUsingGlobalIni - bool

            // Works 100%
            if (settingType == SettingTypes.GameLocation)
            {
                Settings.Default.GameLocation = (string)contents;
            }

            // Works 100%
            else if (settingType == SettingTypes.IsUsingGlobalIni)
            {
                Settings.Default.IsUsingGlobalIni = (bool)contents;
            }

            // Has issues if the directory /data/ does not exist.
            // Save the enblocal.global if it is passed through.
            else if (settingType == SettingTypes.GlobalIniText)
            {
                var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
                var globalIniLocation = Path.Combine(metaLocation, Settings.Default.GlobalIniLocation);

                if (!File.Exists(globalIniLocation))
                    File.Create(globalIniLocation);

                File.WriteAllText(globalIniLocation, (string)contents);
            }
        }

        public static void Apply()
        {
            Settings.Default.Save();
        }
    }

    public class ReadSettings
    {
        public static object Read(SettingTypes settingType)
        {
            // Lol I totally copied and pasted the code from above.

            // Works 100%
            if (settingType == SettingTypes.GameLocation)
            {
                return Settings.Default.GameLocation;
            }

            // Works 100%
            else if (settingType == SettingTypes.IsUsingGlobalIni)
            {
                return Settings.Default.IsUsingGlobalIni;
            }

            // Works 100%
            else if (settingType == SettingTypes.GlobalIniText)
            {
                var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
                var globalIniLocation = Path.Combine(metaLocation, Settings.Default.GlobalIniLocation);

                if (File.Exists(globalIniLocation))
                {
                    return File.ReadAllText(globalIniLocation);
                }
            }

            // lol
            return new NotImplementedException();
        }
    }

    public enum SettingTypes
    {
        GameLocation,
        IsUsingGlobalIni,
        GlobalIniText
    }
}
