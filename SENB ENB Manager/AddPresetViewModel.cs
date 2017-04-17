using GalaSoft.MvvmLight.Command;
using PropertyChanged;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SENB_ENB_Manager
{
    [ImplementPropertyChanged]
    public class AddPresetViewModel
    {
        public ObservableCollection<TestClass> testCollection { get; set; }
        public RelayCommand NextCommand { get; set; }

        public AddPresetViewModel()
        {
            testCollection = new ObservableCollection<TestClass>()
            {
                new TestClass() {Name = "Test", IsChecked = false},
                new TestClass() {Name = "Test", IsChecked = true},
                new TestClass() {Name = "Test", IsChecked = false},
                new TestClass() {Name = "Test", IsChecked = true},
                new TestClass() {Name = "Test", IsChecked = true},
            };
        }
    }

    [ImplementPropertyChanged]
    public class TestClass
    {
        public string Name { get; set; }
        public bool IsChecked { get; set; }
    }
}
