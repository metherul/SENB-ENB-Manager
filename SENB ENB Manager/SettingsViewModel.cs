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

        public string GameLocation { get; set; }
        public bool IsUsingGlobalIni { get; set; }
        public TextDocument GlobalIniText { get; set; }

        public SettingsViewModel()
        {
            OpenIniHelpCommand = new RelayCommand(SomeRandomMethod);

            GameLocation = (string)ReadSettings.Read(SettingTypes.GameLocation);
            IsUsingGlobalIni = (bool)ReadSettings.Read(SettingTypes.IsUsingGlobalIni);
            GlobalIniText = new TextDocument()
            {
                Text = (string)ReadSettings.Read(SettingTypes.GlobalIniText)
            };
        }

        public void SomeRandomMethod()
        {
            SaveSettings.Save(SettingTypes.GameLocation, GameLocation);
            SaveSettings.Save(SettingTypes.IsUsingGlobalIni, IsUsingGlobalIni);
            SaveSettings.Save(SettingTypes.GlobalIniText, GlobalIniText.Text);
        }

        public void OpenIniHelp()
        {
            var wikiURL = @"http://wiki.step-project.com/Guide:ENBlocal_INI";

            Process.Start(wikiURL);
        }
    }
}
