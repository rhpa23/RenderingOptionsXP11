using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Microsoft.Win32;
using XP11SettingsTool.Properties;

namespace XP11SettingsTool
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private IEnumerable<string> _lines;

        private const string FileName = "Settings.lua";
        private const string FileDefaultName = "SettingsDefault.lua";

        public MainWindow()
        {
            InitializeComponent();
        }

        private double GetDoubleValue(string tag)
        {
            try
            {
                var linha = _lines.FirstOrDefault(l => l.Contains(tag));
                var value = linha.Split(',')[1].Replace(")", "");
                return Convert.ToDouble(value, new CultureInfo("en"));
            }
            catch (Exception)
            {
                MessageBox.Show(string.Format("Value {0} not found on script file. Please reinstall.", tag), "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return 0;
            }
        }

        private bool GetBoolValue(string tag)
        {
            try
            {
                var linha = _lines.FirstOrDefault(l => l.Contains(tag));
                var value = linha.Split(',')[1].Replace(")", "");
                return value.Trim() == "1.00";
            }
            catch (Exception)
            {
                MessageBox.Show(string.Format("Value {0} not found on script file. Please reinstall.", tag), "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }
        }

        public static IEnumerable<T> FindVisualChildren<T>(DependencyObject depObj) where T : DependencyObject
        {
            if (depObj != null)
            {
                for (int i = 0; i < VisualTreeHelper.GetChildrenCount(depObj); i++)
                {
                    DependencyObject child = VisualTreeHelper.GetChild(depObj, i);
                    if (child != null && child is T)
                    {
                        yield return (T)child;
                    }

                    foreach (T childOfChild in FindVisualChildren<T>(child))
                    {
                        yield return childOfChild;
                    }
                }
            }
        }

        private void LoadValues(string filePath)
        {
            try
            {
                if (File.Exists(filePath))
                {
                    _lines = File.ReadLines(filePath);

                    foreach (CheckBox ckb in FindVisualChildren<CheckBox>(grdMain))
                    {
                        ckb.IsChecked = GetBoolValue(ckb.Tag.ToString());
                    }

                    foreach (Slider sld in FindVisualChildren<Slider>(grdMain))
                    {
                        sld.Value = GetDoubleValue(sld.Tag.ToString());
                    }
                }
                else
                {
                    MessageBox.Show(this, "File '" + filePath + "' cannot be found. Please reinstall.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(this, ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void SaveFile()
        {
            try
            {
                foreach (CheckBox ckb in FindVisualChildren<CheckBox>(grdMain))
                {
                    var line = _lines.FirstOrDefault(l => l.Contains(ckb.Tag.ToString()));
                    var value = ckb.IsChecked.Value ? " 1.00)" : " 0.00)";
                    var newLine = line.Replace(line.Split(',')[1], value);

                    _lines = _lines.Select(s => s == line ? newLine : s).ToArray();
                }

                foreach (Slider sld in FindVisualChildren<Slider>(grdMain))
                {
                    var line = _lines.FirstOrDefault(l => l.Contains(sld.Tag.ToString()));
                    var value = " " + sld.Value.ToString("0.00", new CultureInfo("en")) + ")";
                    var newLine = line.Replace(line.Split(',')[1], value);

                    _lines = _lines.Select(s => s == line ? newLine : s).ToArray();
                }

                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.FileName = FileName;
                saveFileDialog.DefaultExt = ".lua";
                saveFileDialog.Title = @"Save in folder: XP11\Resources\plugins\FlyWithLua\Scripts\";

                if (Directory.Exists(Settings.Default.FlyWithLuaScriptsFolder))
                    saveFileDialog.InitialDirectory = Settings.Default.FlyWithLuaScriptsFolder;

                if (saveFileDialog.ShowDialog() == true)
                {
                    File.WriteAllLines(saveFileDialog.FileName, _lines); // Na pasta
                    File.WriteAllLines(FileName, _lines); // Local

                    Settings.Default.FlyWithLuaScriptsFolder = System.IO.Path.GetDirectoryName(saveFileDialog.FileName);
                    Settings.Default.Save();
                    MessageBox.Show(this, "Settings saved successfully.", "Info", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(this, ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (File.Exists(FileName))
            {
                LoadValues(FileName);
            }
            else
            {
                LoadValues(FileDefaultName);
            }
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            SaveFile();
        }

        private void btnDefault_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show(this, "Discard all changes and load default XP11 values?", "Question", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                LoadValues(FileDefaultName);    
            }
        }

        private void btnUndo_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show(this, "Discard all current changes?", "Question", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                LoadValues(FileName);
            }
        }

        private void btnExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown(1);
        }
    }
}
