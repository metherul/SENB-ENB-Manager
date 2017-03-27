using ICSharpCode.AvalonEdit.Document;
using SENB_ENB_Manager.Domain;
using System.Diagnostics;
using System.Windows;
using System.Windows.Input;

namespace SENB_ENB_Manager
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void ColorZone_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ChangedButton == MouseButton.Left)
                DragMove();
        }

        private void CloseWindow_Click(object sender, RoutedEventArgs e) => Application.Current.Shutdown();

        private void MinimizeWindow_Click(object sender, RoutedEventArgs e) => WindowState = WindowState.Minimized;
    }
}
