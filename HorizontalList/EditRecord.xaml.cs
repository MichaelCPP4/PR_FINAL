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
    /// Логика взаимодействия для EditRecord.xaml
    /// </summary>
    public partial class EditRecord : Window
    {
        public EditRecord()
        {
            InitializeComponent();
        }

        SkladEntities db = SkladEntities.GetContext();
        Product table = new Product();
        AvailabilityProduct availabilityProduct = new AvailabilityProduct();

        private void BtEdit_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();


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


            table.Title = Titlee.Text;
            table.ProductGroup = ProductGroup.Text;
            table.Manufacturer = Manufacturer.Text;
            table.Image = int.Parse(findImage[0]);

            availabilityProduct.Quantity = quanlity;
            availabilityProduct.IDWarehouse = int.Parse(findSklad[0]);

            db.SaveChanges();

            Close();

            try
            {
                db.SaveChanges();

                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Ошибка!");
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            IDProduct.IsEnabled= false;
            table = db.Products.Find(Data.ID);
            IDProduct.Text = table.ID.ToString();
            Titlee.Text = table.Title;
            ProductGroup.Text = table.ProductGroup;
            Manufacturer.Text = table.Manufacturer.ToString();

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

            //var im = db.Products.Select(p => p.Image).Distinct().ToList();
            //Image row2 = db.Images.SingleOrDefault(w => w.NameImage == table.Image);

            comboImage.SelectedIndex = (int)table.Image-1;
            comboSklad.SelectedIndex = availabilityProduct.IDWarehouse;

            Quantity.Text = availabilityProduct.Quantity.ToString();
        }
    }
}
