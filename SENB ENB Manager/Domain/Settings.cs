using Newtonsoft.Json.Linq;
using SENB_ENB_Manager.Properties;
using System.IO;

namespace SENB_ENB_Manager.Domain
{
    public static class SaveSettings
    {
        public static void Save(SettingTypes type, object content)
        {
            var settingsLocation = Settings.Default.SettingsLocation;
            var settingsContents = File.ReadAllText(settingsLocation);
            var jsonObject = JObject.Parse(settingsContents);

            if (type == SettingTypes.GameLocation)
                jsonObject["GameLocation"] = (string)content;

            else if (type == SettingTypes.UsingGlobalIni)
                jsonObject["UsingGlobalIni"] = (bool)content;

            File.WriteAllText(settingsLocation, jsonObject.ToString());
        }

        public static void BatchSave(SettingValues settingValues)
        {
            var settingsLocation = Settings.Default.SettingsLocation;
            var settingsContents = File.ReadAllText(settingsLocation);
            var jsonObject = JObject.Parse(settingsContents);

            jsonObject["GameLocation"] = settingValues.GameLocation;
            jsonObject["UsingGlobalIni"] = settingValues.UsingGlobalIIni;

            File.WriteAllText(settingsLocation, jsonObject.ToString());
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
                return (string)jsonObject["GameLocation"];

            else if (type == SettingTypes.UsingGlobalIni)
                return (bool)jsonObject["UsingGlobalIni"];

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
                UsingGlobalIIni = (bool)jsonObject["UsingGlobalIni"]
            };

            return settingValues;
        }
    }

    public class SettingValues
    {
        public string GameLocation;
        public bool UsingGlobalIIni;
    }

    public enum SettingTypes
    {
        GameLocation,
        UsingGlobalIni,
        GlobalIniText,
        WikiUrl
    }
}
