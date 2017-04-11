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

        public AddPresetViewModel()
        {
            testCollection = new ObservableCollection<TestClass>()
            {
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test2"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Test"},
                new TestClass() {Name = "Testfinal"},

            };
        }
    }

    [ImplementPropertyChanged]
    public class TestClass
    {
        public string Name { get; set; }
    }
}
