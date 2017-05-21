using GalaSoft.MvvmLight.Command;
using PropertyChanged;
using SENB_ENB_Manager.Model;
using System.Threading;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class AddPresetViewModel
    {
        public string PresetName { get; set; }
        public string PresetDescription { get; set; }
        public RelayCommand AddPresetCommand { get; set; }

        public AddPresetViewModel()
        {
            AddPresetCommand = new RelayCommand(AddPreset);
        }

        public void AddPreset()
        {
            PresetManager.SavePreset(PresetName, PresetDescription);
        }

        // Send the preset to the PresetManager Model, which will create and save the preset. 
        // Pass along the ObservableCollection
    }

    public class SelectionFile
    {
        public string Path;
        public bool IsSelected;
    }
}
