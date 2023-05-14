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
    /// Логика взаимодействия для AddRecord.xaml
    /// </summary>
    public partial class AddRecord : Window
    {
        public AddRecord()
        {
            InitializeComponent();
        }


        SkladEntities db = SkladEntities.GetContext();

        private void BtAdd_Click(object sender, RoutedEventArgs e)
        {

            Product table = new Product();
            AvailabilityProduct availabilityProduct = new AvailabilityProduct();

            StringBuilder errors = new StringBuilder();

            if (!int.TryParse(IDProduct.Text, out int id)) errors.AppendLine("Введите ID продукта.");
            if (Titlee.Text.Length == 0) errors.AppendLine("Введите название продукта.");
            if (ProductGroup.Text.Length == 0) errors.AppendLine("Введите группу продукта.");
            if (Manufacturer.Text.Length == 0) errors.AppendLine("Введите мануфактура");
            if (!int.TryParse(Quantity.Text, out int quanlity)) errors.AppendLine("Введите кол-во продуктов");

            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }

            string[] findImage = comboImage.Text.Split(' ');

            string[] findSklad = comboSklad.Text.Split(' ');


            table.ID = id;
            table.Title = Titlee.Text;
            table.ProductGroup = ProductGroup.Text;
            table.Manufacturer = Manufacturer.Text;
            table.Image = int.Parse(findImage[0]);

            availabilityProduct.IDProduct = id;
            availabilityProduct.Quantity = quanlity;
            availabilityProduct.IDWarehouse = int.Parse(findSklad[0]);

            try
            {
                db.Products.Add(table);
                db.SaveChanges();

                db.AvailabilityProducts.Add(availabilityProduct);
                db.SaveChanges();
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            ComboBoxItem comboItem;
            foreach (var str in db.Images)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = str.ID.ToString() + " " + str.NameImage;
                comboImage.Items.Add(comboItem);
            }

            foreach (var i in db.Warehouses)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = i.ID.ToString() + " " + i.Address;
                comboSklad.Items.Add(comboItem);
            }
        }
    }
}
