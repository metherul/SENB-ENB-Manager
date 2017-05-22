using Newtonsoft.Json.Linq;
using SENB_ENB_Manager.Properties;
using System.IO;

namespace SENB_ENB_Manager.Model
{
    public static class SaveSettings
    {
        public static void Save(SettingTypes type, object content)
        {
            var settingsLocation = Settings.Default.SettingsLocation;
            var settingsContents = File.ReadAllText(settingsLocation);
            var jsonObject = JObject.Parse(settingsContents);

            if (type == SettingTypes.GameLocation)
                jsonObject["GameLocation"] = (string) content;

            if (type == SettingTypes.InstalledPreset)
                jsonObject["InstalledPreset"] = (string) content;

            File.WriteAllText(settingsLocation, jsonObject.ToString());
        }

        public static void BatchSave(SettingValues settingValues)
        {
            var settingsLocation = Settings.Default.SettingsLocation;
            var settingsContents = File.ReadAllText(settingsLocation);
            var jsonObject = JObject.Parse(settingsContents);

            jsonObject["GameLocation"] = settingValues.GameLocation;

            File.WriteAllText(settingsLocation, jsonObject.ToString());
        }

        public static void CreateSettings()
        {
            
        }
    }

    public static class GetSettings
    {
        public static dynamic Return(SettingTypes type)
        {
            var settingsLocation = Settings.Default.SettingsLocation;
            var settingsContents = File.ReadAllText(settingsLocation);
            var jsonObject = JObject.Parse(settingsContents);

            if (type == SettingTypes.GameLocation)
                return (string) jsonObject["GameLocation"];

            if (type == SettingTypes.InstalledPreset)
                return (string) jsonObject["InstalledPreset"];

            // This will legit never happen. Shut up.
            return null;
        }

        public static SettingValues ReturnAll()
        {
            var settingsLocation = Settings.Default.SettingsLocation;
            var settingsContents = File.ReadAllText(settingsLocation);
            var jsonObject = JObject.Parse(settingsContents);

            var settingValues = new SettingValues()
            {
                GameLocation = (string)jsonObject["GameLocation"],
            };

            return settingValues;
        }
    }

    public class SettingValues
    {
        public string GameLocation;
    }

    public enum SettingTypes
    {
        GameLocation,
        InstalledPreset
    }
}
