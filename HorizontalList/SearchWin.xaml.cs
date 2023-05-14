using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;

namespace HorizontalList
{
    /// <summary>
    /// Логика взаимодействия для SearchWin.xaml
    /// </summary>
    public partial class SearchWin : Window
    {
        public SearchWin()
        {
            InitializeComponent();
        }

        SkladEntities db = new SkladEntities();

        private void BtSeach_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Data.Title = NameProduct.Text;
                Data.Sklad = comboSklad.Text;
                Data.Manufacturer = comboManufacturer.Text;
                Close();
            }
            catch (System.InvalidOperationException)
            {
                MessageBox.Show("Введите запрос");
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            ComboBoxItem comboItem;

            foreach (var str in db.Warehouses)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = str.Address;
                comboSklad.Items.Add(comboItem);
            }

            foreach (var str in db.Products)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = str.Manufacturer;
                comboManufacturer.Items.Add(comboItem);
            }
        }
    }
}