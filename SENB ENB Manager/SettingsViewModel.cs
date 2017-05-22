using System;
using GalaSoft.MvvmLight.Command;
using ICSharpCode.AvalonEdit.Document;
using SENB_ENB_Manager.Model;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using FolderSelect;
using MaterialDesignThemes.Wpf;
using PropertyChanged;
using SENB_ENB_Manager.Properties;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class SettingsViewModel
    {
        public ICommand OpenIniHelpCommand => new CommandImplementation(OpenIniHelp);
        public ICommand EditGlobalIniCommand => new CommandImplementation(OpenEditGlobalIniDialog);
        public ICommand SaveSettingsCommand => new CommandImplementation(SaveSettings);
        public ICommand OpenFileBrowserCommand => new CommandImplementation(OpenFileBrowser);

        public string GameLocation { get; set; }
        public TextDocument GlobalIniText { get; set; }

        public SettingsViewModel()
        {
            var metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            var globalIniLocation = Path.Combine(metaLocation, Settings.Default.GlobalIniLocation);
            var settings = GetSettings.ReturnAll();
            GameLocation = settings.GameLocation;
            var globalIniFile = File.ReadAllText(globalIniLocation);
            GlobalIniText = new TextDocument {Text = globalIniFile != "" ? globalIniFile : ""};
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