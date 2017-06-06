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
using System.Diagnostics;

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
                var linha = _lines.FirstOrDefault(l => l.Contains("setData(findDataref(\"" + tag));
                linha = CheckNotFoundLine(tag, linha);

                var value = linha.Split(',')[1].Replace(")", "");
                return Convert.ToDouble(value, new CultureInfo("en"));
            }
            catch (Exception)
            {
                MessageBox.Show(string.Format("Value {0} not found on script file. Please reinstall.", tag), "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return 0;
            }
        }

        private string CheckNotFoundLine(string tag, string linha)
        {
            if (linha == null)
            {
                // Get from default script to avalible updates without erros.
                var linhasDefault = File.ReadLines(FileDefaultName);
                linha = linhasDefault.FirstOrDefault(l => l.Contains("setData(findDataref(\"" + tag));
                List<string> linesList = _lines.ToList();
                
                linesList.Insert(linesList.FindLastIndex(x => x.Contains("end")) - 2, linha);

                _lines = linesList.ToArray();
            }
            return linha;
        }

        private bool GetBoolValue(string tag)
        {
            try
            {
                var linha = _lines.FirstOrDefault(l => l.Contains("setData(findDataref(\"" + tag));
                linha = CheckNotFoundLine(tag, linha);

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

                    if (File.Exists(FileName))
                    {
                        var newList = new List<string>();
                        var savedLines = File.ReadLines(FileName);
                        foreach (var line in _lines.ToList())
                        {
                            if (savedLines.Any(x => x.Split(',')[0] == line.Split(',')[0]))
                            {
                                var s = savedLines.FirstOrDefault(x => x.Split(',')[0] == line.Split(',')[0]);
                                newList.Add(s);
                            }
                            else
                                newList.Add(line);
                        }
                        _lines = newList.ToList();
                    }

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
                    var line = _lines.FirstOrDefault(l => l.Contains("setData(findDataref(\"" + ckb.Tag.ToString()));
                   // line = CheckNotFoundLine(ckb.Tag.ToString(), line);
                    var value = ckb.IsChecked.Value ? " 1.00" : " 0.00";
                    var newLine = line.Replace(line.Split(',')[1], value);

                    _lines = _lines.Select(s => s == line ? newLine : s).ToArray();
                }

                foreach (Slider sld in FindVisualChildren<Slider>(grdMain))
                {
                    var line = _lines.FirstOrDefault(l => l.Contains("setData(findDataref(\"" + sld.Tag.ToString()));
                 //   line = CheckNotFoundLine(sld.Tag.ToString(), line);
                    var value = " " + sld.Value.ToString("0.00", new CultureInfo("en")) ;
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

        private void LoadDefaultFileValues()
        {
            try
            {
                string fileDefaultSettings =  Settings.Default.FlyWithLuaScriptsFolder + "\\default_settings.txt";
                if (File.Exists(fileDefaultSettings))
                {
                    var lines = File.ReadLines(fileDefaultSettings);

                    foreach (CheckBox ckb in FindVisualChildren<CheckBox>(grdMain))
                    {
                        var line = lines.FirstOrDefault(x => x.Contains(ckb.Tag.ToString()));
                        if (line != null)
                        {
                            ckb.IsChecked = line.Split('=')[1].Trim() == "1";
                        }
                    }

                    foreach (Slider sld in FindVisualChildren<Slider>(grdMain))
                    {
                        var line = lines.FirstOrDefault(x => x.Contains(sld.Tag.ToString()));

                        if (line != null)
                        {
                            var value = line.Split('=')[1].Trim();
                            sld.Value = Convert.ToDouble(value, new CultureInfo("en"));
                        }
                    }
                }
                else
                {
                    MessageBox.Show(this, "The default X-Plane values cannot be found. Please save yours settings in FlywithLua Scripts folder restart X-Plane and try again.", "Exclamation", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(this, ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }


        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LoadValues(FileDefaultName);
            DonateLink.NavigateUri = new Uri(@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=B2GHF8WFN95JW&lc=BR&item_name=rhpa23&currency_code=USD&bn=PP-DonationsBF%3Abtn_donateCC_LG.gif%3ANonHosted");
        }
        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            Process.Start(new ProcessStartInfo(e.Uri.AbsoluteUri));
            e.Handled = true;
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
                //LoadValues(FileDefaultName);    
                LoadDefaultFileValues();
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
