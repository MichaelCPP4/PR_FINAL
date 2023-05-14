using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;
using System.Linq;
using System.Runtime.Remoting.Contexts;
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
using System.Windows.Threading;

namespace HorizontalList
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
  public partial class MainWindow : Window
  {
    public MainWindow()
    {
      InitializeComponent();


            var products = db.TableViews.ToList();
            if (products.Count > 0)
                listview.ItemsSource = products;

            var view = CollectionViewSource.GetDefaultView(listview.ItemsSource);
            view.SortDescriptions.Add(new SortDescription("ID", ListSortDirection.Ascending));

            listview.ItemsSource = view;
    }

        SkladEntities db = SkladEntities.GetContext();

        private void BtAdd_Click(object sender, RoutedEventArgs e)
        {
            AddRecord add = new AddRecord();
            add.Owner = this;
            add.ShowDialog();
/*
            var myTableData = db.TableViews.ToList();
            listview.ItemsSource = myTableData;
                        db.TableViews.Load();
                        listview.ItemsSource = db.TableViews.Local.ToBindingList();*/
        }

        private void BtEdit_Click(object sender, RoutedEventArgs e)
        {

            int indexRow = listview.SelectedIndex;
            if (indexRow != -1)
            {
                TableView row = (TableView)listview.Items[indexRow];
                Data.ID = row.ID;
                EditRecord windowEdit = new EditRecord();
                windowEdit.Owner = this;
                windowEdit.ShowDialog();
                listview.Items.Refresh();
            }
        }

        private void BtDelete_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result;
            result = MessageBox.Show("Удалить продукт?", "Удаление продукта.",
                MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (result == MessageBoxResult.Yes)
            {
                try
                {
                    TableView viewRow = (TableView)listview.SelectedValue;
                    Product row = db.Products.Find(viewRow.ID);
                    db.Products.Remove(row);
                    db.SaveChanges();
                    listview.Items.Refresh();
                    db.ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                }
                catch (ArgumentOutOfRangeException)
                {

                    MessageBox.Show("Есть связанная таблица", "Ошибка!");
                }
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // Вход и определение прав пользователя
            Login login = new Login();
            login.ShowDialog();

            if (Data.Login == false) Close();
            if (Data.Right != "Администратор")
            {
                add.IsEnabled = false;
                edit.IsEnabled = false;
                delete.IsEnabled = false;
                //delete2.IsEnabled = false;
            }

            mainWin.Title = Data.FullName + " - " + Data.Right;
        }

        private void BtDelete2_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result;
            result = MessageBox.Show("ВНИМАНИЕ! При удалении единственного склада, удалится и сам продукт.", "Удаление склада.",
                MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (result == MessageBoxResult.Yes)
            {
                try
                {
                    TableView viewRow = (TableView)listview.SelectedValue;
                    //AvailabilityProduct row = db.AvailabilityProducts;
                    //Warehouse row2 = db.Warehouses.Find(viewRow.Address);

                    Product row = db.Products.SingleOrDefault(w => w.Title == viewRow.Title);

                    Warehouse row2 = db.Warehouses.SingleOrDefault(w => w.Address == viewRow.Address);


                    var availabilityProduct = db.AvailabilityProducts.FirstOrDefault(p => p.IDProduct == viewRow.ID && p.IDWarehouse == row2.ID);
                    //var product = db.Products.FirstOrDefault(p => p.ID == row.ID);

                    //db.Products.Remove(product);
                    db.AvailabilityProducts.Remove(availabilityProduct);
                    db.SaveChanges(); 
                    listview.Items.Refresh();
                    db.ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                }
                catch (ArgumentOutOfRangeException)
                {

                    MessageBox.Show("Есть связанная таблица", "Ошибка!");
                }
            }
        }

        private void BtSeach_Click(object sender, RoutedEventArgs e)
        {
            SearchWin win = new SearchWin();
            win.Owner = this;
            win.ShowDialog();

            // Проверка каждой записи в listview до нахождения соответствия
            foreach (var item in listview.Items)
            {
                var row = (TableView)item;
                string title = row.Title.ToString();
                string address = row.Address;
                string manufacturer = Data.Manufacturer;

                if (title.Contains(Data.Title) && address.Contains(Data.Sklad) && manufacturer.Contains(Data.Manufacturer))
                {
                    listview.SelectedItem = item;
                    listview.ScrollIntoView(item);
                    break;
                }
            }
        }

        private void BtReset_Click(object sender, RoutedEventArgs e)
        {/*
            db.TableViews.Load();
            listview.ItemsSource = db.TableViews.Local.ToBindingList();*/

            var products = db.TableViews.ToList();
            if (products.Count > 0)
                listview.ItemsSource = products;

            var view = CollectionViewSource.GetDefaultView(listview.ItemsSource);
            view.SortDescriptions.Add(new SortDescription("ID", ListSortDirection.Ascending));

            listview.ItemsSource = view;
        }

        private void BtFilter_Click(object sender, RoutedEventArgs e)
        {
            Filter win = new Filter();
            win.Owner = this;
            win.ShowDialog();

            db.TableViews.Load();
            listview.ItemsSource = db.TableViews.Local.ToBindingList();

            try
            {
                var table = db.TableViews.ToList();
                IEnumerable<TableView> filtered;
                if (Data.Param == "Группа продукта") filtered = table.Where(p => p.ProductGroup.Contains(Data.Filter));
                else filtered = table.Where(p => p.Manufacturer.Contains(Data.Filter));
                listview.ItemsSource = filtered;
            }
            catch { }
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            stackpanel.IsEnabled = true;
        }

        private void BtExit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void BtInfo_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Автор: Иванов Михаил ИСП-31.\nВариант №1","О программе.");
        }
    }
}