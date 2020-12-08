using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace Building
{
    public partial class mainForm : Form
    {
        MySqlConnection connSql;
        MySqlDataAdapter adapter;
        DataSet ds;

        // admin, leader, worker
        int user;

        List<string> items;

        string currentTable;

        public mainForm(ref MySqlConnection _connSql, ref int _user)
        {
            InitializeComponent();

            connSql = _connSql;
            user = _user;

            initializeTableList();

            comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            comboBox2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
        }

        // Инициализация списка атрибутов для поиска
        private void initializeTableSearch()
        {
            comboBox2.Items.Clear();

            foreach (string item in items)
            {
                comboBox2.Items.Add(item);
            }
        }


        // Список таблиц
        private void initializeTableList()
        {
            comboBox1.Items.Clear();

            string cmdStr = "SHOW TABLES FROM building";
            MySqlCommand command = new MySqlCommand(cmdStr, connSql);

            using (MySqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    if (user == 2)
                    {
                        // У работника нет доступа к этим таблицам
                        if (reader.GetString(0) == "специализация" || reader.GetString(0) == "должности" || reader.GetString(0) == "бригады" || reader.GetString(0) == "сотрудники")
                        {
                            continue;
                        }
                    }
                    comboBox1.Items.Add(reader.GetString(0));
                }
                reader.Close();
            }

            if (comboBox1.Items.Count > 0)
            {
                comboBox1.SelectedIndex = 0;
            }
        }


        private void initializeField()
        {
            checkedListBox1.Items.Clear();

            MySqlCommand command = new MySqlCommand("SHOW COLUMNS FROM " +
                comboBox1.SelectedItem.ToString(), connSql);

            items = new List<string>();

            using (MySqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    checkedListBox1.Items.Add(reader.GetString(0));
                    items.Add(reader.GetString(0));
                }

                reader.Close();
            }

            for (int i = 0; i < checkedListBox1.Items.Count; i++)
            {
                checkedListBox1.SetItemChecked(i, true);
            }

            initializeTableSearch();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                currentTable = comboBox1.SelectedItem.ToString();

                string queryStr = "SELECT ";

                queryStr += "* FROM " + currentTable;

                adapter = new MySqlDataAdapter(queryStr, connSql);
                ds = new DataSet();

                adapter.Fill(ds, currentTable);
                dataGridView1.DataSource = ds.Tables[currentTable];

                initializeField();
            }
            catch
            {
                MessageBox.Show("Ошибка. \nНекорректные действия!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void dataGridView1_RowValidated(object sender, DataGridViewCellEventArgs e)
        {
            DataTable changes = ((DataTable)dataGridView1.DataSource).GetChanges();

            if (changes != null)
            {
                if (MessageBox.Show("Подтверждаете произведённые изменения?", "База данных", MessageBoxButtons.OKCancel, MessageBoxIcon.Question) == DialogResult.OK)
                {
                    try
                    {
                        MySqlCommandBuilder mcd = new MySqlCommandBuilder(adapter);
                        adapter.UpdateCommand = mcd.GetUpdateCommand();
                        adapter.Update(changes);
                        ((DataTable)dataGridView1.DataSource).AcceptChanges();
                    }
                    catch
                    {
                        MessageBox.Show("Не удалось произвести операцию!", "Ошибка",
                                MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        // Отсутствие фокуса на поле ввода
        private void textBox1_Leave(object sender, EventArgs e)
        {
            if (textBox1.Text == "")
            {
                textBox1.Text = "Что найти?";
                textBox1.ForeColor = System.Drawing.Color.Gray;
            }
        }

        // Появление фокуса на поле ввода
        private void textBox1_Enter(object sender, EventArgs e)
        {
            if (textBox1.Text == "Что найти?")
            {
                textBox1.Clear();
                textBox1.ForeColor = System.Drawing.Color.Black;
            }
        }

        string temp;

        private void mainForm_Text(object sender, EventArgs e)
        {


            if (user == 0)
            {
                temp = "Администратор";
            }
            else if (user == 1)
            {
                temp = "Руководитель";
            }
            else if (user == 2)
            {
                temp = "Служащий";
            }
            else
            {
                temp = "Неизвестный";
            }
            this.Text = "БД строительной фирмы." + temp.ToUpper();
            label2.Text = temp.ToUpper();




        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (comboBox2.SelectedIndex == -1)
            {
                return;
            }

            if (textBox1.Text != "" && textBox1.Text != "Что найти?")
            {
                string filter = string.Format("[{0}] ", comboBox2.SelectedItem.ToString());

                if (comboBox2.SelectedItem.ToString().Contains("Код") || comboBox2.SelectedItem.ToString().Contains("Стоимость") || comboBox2.SelectedItem.ToString().Contains("Зарплата") || comboBox2.SelectedItem.ToString().Contains("Количество"))
                {
                    filter += string.Format(" = {0}", textBox1.Text);
                }
                else
                {

                    filter += string.Format(" LIKE '%{0}%'", textBox1.Text);

                }

                try
                {
                    (dataGridView1.DataSource as DataTable).DefaultView.RowFilter = filter;
                }
                catch
                {
                }
            }
            else
            {
                (dataGridView1.DataSource as DataTable).DefaultView.RowFilter = null;
            }
        }

        private void checkLastItem()
        {
            int counter = 0;

            for (int i = 0; i < checkedListBox1.Items.Count; i++)
            {
                if (checkedListBox1.GetItemChecked(i))
                {
                    counter++;
                }
            }

            if (checkedListBox1.Items.Count != 0 && counter == 0)
            {
                checkedListBox1.SetItemChecked(0, true);
            }
        }

        private void checkedListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            checkLastItem();

            items = new List<string>();

            for (int i = 0; i < checkedListBox1.Items.Count; i++)
            {
                if (checkedListBox1.GetItemChecked(i))
                {
                    items.Add(checkedListBox1.Items[i].ToString());
                }
            }

            string queryStr = "SELECT ";

            for (int i = 0; i < items.Count; i++)
            {
                queryStr += string.Format("{0}", items[i]);

                if (i != items.Count - 1)
                {
                    queryStr += ",";
                }

                queryStr += " ";
            }

            queryStr += " FROM " + comboBox1.SelectedItem.ToString();

            MySqlCommand command = new MySqlCommand(queryStr, connSql);
            adapter = new MySqlDataAdapter(queryStr, connSql);
            ds = new DataSet();

            adapter.Fill(ds, comboBox1.SelectedItem.ToString());
            dataGridView1.DataSource = ds.Tables[comboBox1.SelectedItem.ToString()];

            initializeTableSearch();
        }




        private void button1_Click_1(object sender, EventArgs e)
        {
            string queryStr = string.Format("SELECT SUM(Стоимость) FROM Заказы WHERE Дата_окончания BETWEEN '{0}' AND '{1}'",
            dateTimePicker1.Value.ToString("yyyy-MM-dd"), dateTimePicker2.Value.ToString("yyyy-MM-dd"));
            MySqlCommand command = new MySqlCommand(queryStr, connSql);
            MySqlDataReader reader = command.ExecuteReader();

            string __out = "0";

            while (reader.Read())
            {
                __out = reader.GetValue(0).ToString();
            }


            MessageBox.Show("Прибыль компании за данный период составляет: " + (__out == "" ? "0" : __out) + " р.", "Прибыль компании",
                MessageBoxButtons.OK, MessageBoxIcon.Information);

            reader.Close();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }


        private void printDocument1_PrintPage(object sender, PrintPageEventArgs e)
        {
            Bitmap bmp = new Bitmap(dataGridView1.Size.Width, dataGridView1.Size.Height);
            dataGridView1.DrawToBitmap(bmp, new Rectangle(0, 0, this.dataGridView1.Width, this.dataGridView1.Height));
            e.Graphics.DrawImage(bmp, 50, 170);
            e.Graphics.DrawString("Вывод на печать таблицы: " + comboBox1.SelectedItem.ToString(), new Font("Arial", 14), Brushes.Black, 50, 100);
            e.Graphics.DrawString("25.11.2019 14:06:16", new Font("Arial", 14), Brushes.Black, 585, 50);
            e.Graphics.DrawString("Распечатал: " + temp, new Font("Arial", 14), Brushes.Black, 50, 130);


        }

        //DateTime.Now
        private void button2_Click(object sender, EventArgs e)
        {
            printPreviewDialog1.Document = printDocument1;
            printPreviewDialog1.ShowDialog();
        }




    }
}

