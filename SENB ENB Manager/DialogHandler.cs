using MaterialDesignThemes.Wpf;
using PropertyChanged;
using SENB_ENB_Manager.Model;
using System.Windows.Input;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class DialogHandler
    {
        public ICommand EditBinariesCommand => new CommandImplementation(OpenEditBinariesDialog);

        private async void OpenEditBinariesDialog(object o)
        {
            var view = new EditBinariesView();
            await DialogHost.Show(view, "RootDialog", CloseEditBinariesDialog);
        }
        private void CloseEditBinariesDialog(object sender, DialogClosingEventArgs eventargs)
        {
            
        }


    }
}
