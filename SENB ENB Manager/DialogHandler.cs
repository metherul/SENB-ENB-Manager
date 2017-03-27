using GalaSoft.MvvmLight.Command;
using PropertyChanged;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class DialogHandler
    {
        public RelayCommand<object> ChangeVisibilityCommand { get; set; }
        
        // Long names, I know.
        // They each enable their respective dialogs. 
        public bool IsEditBinariesViewVisible { get; set; }
        public bool IsEditGlobalIniViewVisible { get; set; }
        public bool IsAddPresetViewVisible { get; set; }

        public DialogHandler()
        {
            ChangeVisibilityCommand = new RelayCommand<object>(ChangeVisibility);
        }

        public void ChangeVisibility(object parameter)
        {
            var view = parameter.ToString();

            if (view == "EditBinariesView")
                IsEditBinariesViewVisible = !IsEditBinariesViewVisible;

            else if (view == "EditGlobalIniView")
                IsEditGlobalIniViewVisible = !IsEditGlobalIniViewVisible;

            else if (view == "AddPresetView")
                IsAddPresetViewVisible = !IsAddPresetViewVisible;
        }
    }
}
