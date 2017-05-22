using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using PropertyChanged;
using SENB_ENB_Manager.Model;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class MainViewViewModel
    {
        public ICommand OpenGameDirectoryCommand => new CommandImplementation(OpenGameDirectory);

        public void OpenGameDirectory(object o)
        {
            var gameDirectory = GetSettings.Return(SettingTypes.GameLocation);
            if (gameDirectory != "") Process.Start(gameDirectory);
        }
    }
}
