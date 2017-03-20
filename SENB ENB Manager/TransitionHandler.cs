using GalaSoft.MvvmLight.Command;
using PropertyChanged;
using System;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    class TransitionHandler
    {
        // Sets the current focused UserControl
        public int CurrentViewIndex { get; set; }

        // Handle buttons to change view in XAML
        // object handles the current view.
        public RelayCommand<object> ChangeViewCommand { get; set; }

        public TransitionHandler()
        {
            ChangeViewCommand = new RelayCommand<object>(SetCurrentView);
        }

        public void SetCurrentView(object parameter)
        {
            CurrentViewIndex = Convert.ToInt32(parameter);
        }
    }
}
