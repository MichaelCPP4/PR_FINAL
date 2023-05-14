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
    /// Логика взаимодействия для Filter.xaml
    /// </summary>
    public partial class Filter : Window
    {
        public Filter()
        {
            InitializeComponent();
        }

        SkladEntities db = new SkladEntities();

        private void BtFilter_Click(object sender, RoutedEventArgs e)
        {
            Data.Param = comboParam.Text;
            Data.Filter = comboFilter.Text;
            Close();
        }

        private void Combo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            comboFilter.Items.Clear();

            var productGroups = db.Products.Select(p => p.ProductGroup).Distinct().ToList();
            var manufacturer = db.Products.Select(p => p.Manufacturer).Distinct().ToList();

            ComboBox comboBox = sender as ComboBox;
            if (comboBox != null)
            {
                ComboBoxItem selectedItem = comboBox.SelectedItem as ComboBoxItem;
                if (selectedItem != null)
                {
                    if (selectedItem.Content.ToString() == "Группа продукта")
                    {
                        foreach (var group in productGroups)
                        {
                            ComboBoxItem comboItem = new ComboBoxItem();
                            comboItem.Content = group;
                            comboFilter.Items.Add(comboItem);
                        }
                    }
                    else if (selectedItem.Content.ToString() == "Производитель")
                    {
                        foreach (var manuf in manufacturer)
                        {
                            ComboBoxItem comboItem = new ComboBoxItem();
                            comboItem.Content = manuf;
                            comboFilter.Items.Add(comboItem);
                        }
                    }
                }
            }

            comboFilter.IsEnabled = true;
        }

        private void Filt_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Search_btn.IsEnabled = true;
        }
    }
}
