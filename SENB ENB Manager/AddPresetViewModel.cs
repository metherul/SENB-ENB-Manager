using MaterialDesignThemes.Wpf;
using PropertyChanged;
using SENB_ENB_Manager.Model;
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class AddPresetViewModel
    {
        public ICommand PresetDialogCommand => new CommandImplementation(OpenPresetDialog);
        public ICommand InstallPresetCommand => new CommandImplementation(InstallPreset);
        public ICommand UninstallPresetCommand => new CommandImplementation(UninstallPreset);
        public ICommand CleanGameDirectoryCommand => new CommandImplementation(CleanGameDirectory);
        public ObservableCollection<PresetData> Presets { get; set; }

        public string PresetName { get; set; }
        public string PresetDescription { get; set; }
        public bool IsHintVisible { get; set; }
        public bool UsingGlobalIni { get; set; }

        public AddPresetViewModel()
        {
            var output = ApplicationContinuity.VerifyAll();

            Presets = new ObservableCollection<PresetData>(PresetManager.GetPresets());
            IsHintVisible = Presets.Count <= 0;
        }

        private async void OpenPresetDialog(object o)
        {
            var view = new AddPresetView();

            await DialogHost.Show(view, "RootDialog", ClosePresetDialog);
        }
        private void ClosePresetDialog(object sender, DialogClosingEventArgs eventargs)
        {
            // Close the dialog unless more commands are needed.
            if ((bool)eventargs.Parameter == false) return;
            if (PresetName == null) return;
            if (GetSettings.Return(SettingTypes.GameLocation) == "") return;

            PresetManager.SavePreset(PresetName, PresetDescription, UsingGlobalIni);

            Presets = new ObservableCollection<PresetData>(PresetManager.GetPresets());

            PresetName = null;
            PresetDescription = null;

            IsHintVisible = Presets.Count <= 0;
        }

        private void InstallPreset(object o)
        {
            if ((string) o == GetSettings.Return(SettingTypes.InstalledPreset))
            {
                PresetManager.CleanGameDirectory();
                SaveSettings.Save(SettingTypes.InstalledPreset, "");
            }

            else
            {
                PresetManager.InstallPreset((string)o);
            }

            Presets = new ObservableCollection<PresetData>(PresetManager.GetPresets());
        }

        private void UninstallPreset(object o)
        {
            PresetManager.UninstallPreset((string)o);
            Presets = new ObservableCollection<PresetData>(PresetManager.GetPresets());

            IsHintVisible = Presets.Count <= 0;
        }

        private void CleanGameDirectory(object o)
        {
            PresetManager.CleanGameDirectory(true);
            Presets = new ObservableCollection<PresetData>(PresetManager.GetPresets());
        }
    }

    public class PresetData
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public bool IsInstalled { get; set; }
        public string BinaryVersion { get; set; }
        public string IconType { get; set; }
    }
}
