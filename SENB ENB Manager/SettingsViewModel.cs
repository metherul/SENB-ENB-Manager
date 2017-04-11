using GalaSoft.MvvmLight.Command;
using ICSharpCode.AvalonEdit.Document;
using SENB_ENB_Manager.Model;
using System.ComponentModel;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace SENB_ENB_Manager
{
    // For this VM we have to impliment INotifyPropertyChanged manually. I know it sucks, but you can't really do anything about it.
    // In the current implimentation the program will save when each value changes. Each setting is small, so I'm not expecting any issues to come out of this.
    public class SettingsViewModel : INotifyPropertyChanged
    {
        public RelayCommand OpenIniHelpCommand { get; set; }

        private string gameLocation;
        public string GameLocation
        {
            get { return gameLocation; }
            set
            {
                gameLocation = value;
                SaveSettings.Save(SettingTypes.GameLocation, value);
                NotifyPropertyChanged();
            }
        }

        private bool usingGlobalIni;
        public bool UsingGlobalIni
        {
            get { return usingGlobalIni; }
            set
            {
                usingGlobalIni = value;
                SaveSettings.Save(SettingTypes.UsingGlobalIni, value);
                NotifyPropertyChanged();
            }
        }
        public TextDocument GlobalIniText { get; set; }

        public SettingsViewModel()
        {
            OpenIniHelpCommand = new RelayCommand(OpenIniHelp);

            var settings = GetSettings.ReturnAll();
            GameLocation = settings.GameLocation;
            UsingGlobalIni = settings.UsingGlobalIIni;
        }

        public event PropertyChangedEventHandler PropertyChanged;
        private void NotifyPropertyChanged([CallerMemberName] string propertyName = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
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
    }
}
