using FolderSelect;
using ICSharpCode.AvalonEdit.Document;
using MaterialDesignThemes.Wpf;
using PropertyChanged;
using SENB_ENB_Manager.Model;
using SENB_ENB_Manager.Properties;
using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Input;
using Microsoft.Win32;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class SettingsViewModel
    {
        public ICommand OpenIniHelpCommand => new CommandImplementation(OpenIniHelp);
        public ICommand EditGlobalIniCommand => new CommandImplementation(OpenEditGlobalIniDialog);
        public ICommand SaveSettingsCommand => new CommandImplementation(SaveSettings);
        public ICommand OpenFileBrowserCommand => new CommandImplementation(OpenFileBrowser);
        public ICommand EndoreMeCommand => new CommandImplementation(EndorseMe);

        public string GameLocation { get; set; }
        public TextDocument GlobalIniText { get; set; }

        public SettingsViewModel()
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var globalIniLocation = Path.Combine(metaLocation, Settings.Default.GlobalIniLocation);
            var globalIniFile = File.ReadAllText(globalIniLocation);
            GlobalIniText = new TextDocument {Text = globalIniFile != "" ? globalIniFile : ""};

            GameLocation = GetSettings.Return(SettingTypes.GameLocation);

            if (GameLocation != "") return;

            var regKey = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\WOW6432Node\Bethesda Softworks\Skyrim");
            if (regKey != null)
            {
                var value = (string) regKey.GetValue("Installed Path");

                GameLocation = value;
            }
            Model.SaveSettings.Save(SettingTypes.GameLocation, GameLocation);
        }

        public void OpenIniHelp(object o)
        {
            Process.Start(Settings.Default.WikiUrl);
        }

        public void SaveSettings(object o)
        {
            Model.SaveSettings.BatchSave(new SettingValues()
            {
                GameLocation = GameLocation
            });
        }

        private void OpenFileBrowser(object o)
        {
            var fileDialog = new FolderSelectDialog
            {
                Title = "Game Directory",
                InitialDirectory = @"C:\"
            };

            if (fileDialog.ShowDialog(IntPtr.Zero))
            {
                GameLocation = fileDialog.FileName;
            }
        }

        private void EndorseMe(object o)
        {
            Process.Start("http://www.nexusmods.com/skyrim/mods/84060?");
        }


        private async void OpenEditGlobalIniDialog(object o)
        {
            var view = new EditGlobalIniView();
            await DialogHost.Show(view, "RootDialog", CloseEditGlobalIniDialog);

        }
        private void CloseEditGlobalIniDialog(object sender, DialogClosingEventArgs eventargs)
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var globalIniLocation = Path.Combine(metaLocation, Settings.Default.GlobalIniLocation);

            File.WriteAllText(globalIniLocation, GlobalIniText.Text);
        }
    }
}