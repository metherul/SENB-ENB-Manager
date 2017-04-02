using GalaSoft.MvvmLight.Command;
using ICSharpCode.AvalonEdit.Document;
using PropertyChanged;
using SENB_ENB_Manager.Domain;
using System.Diagnostics;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class SettingsViewModel
    {
        public RelayCommand OpenIniHelpCommand { get; set; }
        public RelayCommand SaveSettingsCommand { get; set; }

        public string GameLocation { get; set; }
        public bool UsingGlobalIni { get; set; }
        public TextDocument GlobalIniText { get; set; }

        public SettingsViewModel()
        {
            OpenIniHelpCommand = new RelayCommand(OpenIniHelp);
            SaveSettingsCommand = new RelayCommand(SaveAllSettings, SaveSettingsCommandEnabled);

            var settings = GetSettings.ReturnAll();
            GameLocation = settings.GameLocation;
            UsingGlobalIni = settings.UsingGlobalIIni;
        }

        public void OpenIniHelp()
        {
            Process.Start(GetSettings.Return(SettingTypes.WikiUrl));
        }

        public void SaveAllSettings()
        {
            SaveSettings.BatchSave(new SettingValues()
            {
                GameLocation = GameLocation,
                UsingGlobalIIni = UsingGlobalIni
            });
        }

        public bool SaveSettingsCommandEnabled()
        {
            return false;
        }
    }
}
