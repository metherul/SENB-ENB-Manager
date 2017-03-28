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
        public bool IsUsingGlobalIni { get; set; }
        public TextDocument GlobalIniText { get; set; }

        public SettingsViewModel()
        {
            OpenIniHelpCommand = new RelayCommand(OpenIniHelp);
            SaveSettingsCommand = new RelayCommand(SaveSettings);

            GameLocation = (string)ReadSettings.Read(SettingTypes.GameLocation);
            IsUsingGlobalIni = (bool)ReadSettings.Read(SettingTypes.IsUsingGlobalIni);
            GlobalIniText = new TextDocument()
            {
                Text = (string)ReadSettings.Read(SettingTypes.GlobalIniText)
            };
        }

        // Save settings on user exit.
        ~SettingsViewModel()
        {
            Domain.SaveSettings.Apply();
        }

        public void OpenIniHelp()
        {
            var wikiURL = @"http://wiki.step-project.com/Guide:ENBlocal_INI";

            Process.Start(wikiURL);
        }

        public void SaveSettings()
        {
            Domain.SaveSettings.Save(SettingTypes.GameLocation, GameLocation);
            Domain.SaveSettings.Save(SettingTypes.IsUsingGlobalIni, IsUsingGlobalIni);
            Domain.SaveSettings.Save(SettingTypes.GlobalIniText, GlobalIniText.Text);
        }
    }
}
