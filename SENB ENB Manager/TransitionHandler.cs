using GalaSoft.MvvmLight.Command;
using PropertyChanged;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    class TransitionHandler
    {
        // Index Directory
        // 0 - MainView
        // 1 - SettingsView
        // 2 - EditBinariesView
        // 3 - EditGlobalIniView

        // Sets the current focused UserControl
        public int CurrentViewIndex { get; set; }

        // Handle buttons to change view in XAML
        // object handles the current view.
        public RelayCommand<object> ChangeViewCommand { get; set; }

        public TransitionHandler()
        {
            ChangeViewCommand = new RelayCommand<object>(SetCurrentView);
        }

        // Sets the current selected UserControl
        public void SetCurrentView(object parameter)
        {
            var selectedView = parameter.ToString();

            if (selectedView == "MainView") CurrentViewIndex = 0;
            else if (selectedView == "SettingsView") CurrentViewIndex = 1;
            else if (selectedView == "EditBinariesView") CurrentViewIndex = 2;
            else if (selectedView == "EditGlobalIniView") CurrentViewIndex = 3;
        }
    }
}
