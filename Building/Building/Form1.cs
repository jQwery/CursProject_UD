using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace Building
{
    public partial class EtnerForm : Form
    {
        MySqlConnection connSql;
        private string userStr = "";
        private string passStr = "";
        int user = 0;

        public EtnerForm()
        {
            InitializeComponent();
        }


        // Кнопка войти
        private void button1_Click_1(object sender, EventArgs e)
        {
            userStr = textBox1.Text;
            passStr = textBox2.Text;

            if (!isEnter())
            {
               MessageBox.Show("Ошибка подключения к базе данных. Некорректные данные.", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
                {
                mainForm form = new mainForm(ref connSql, ref user);
                this.Hide();
                form.ShowDialog();
                this.Show();
           }
        }

        // Валидация значений
        private bool isEnter()
        {
            if (connSql != null)
            {
                connSql.Close();
            }

            connSql = new MySqlConnection("server=localhost;port=3306;username=" + userStr + ";password=" + passStr + ";database=vetklin1;");
            MySqlCommand command = connSql.CreateCommand();

            MySqlDataReader reader;
            command.CommandText = "SELECT 1";

            try
            {
                connSql.Open();
                reader = command.ExecuteReader();
                reader.Close();

                if (userStr == "admin")
                {
                    user = 0;
                }
                else if (userStr == "leader")
                {
                    user = 1;
                }
                else if (userStr == "worker")
                {
                    user = 2;
                }

                return true;
            }
            catch
            {
                return false;
            }
        }

        private void EtnerForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (connSql != null)
            {
                connSql.Close();
            }
        }



        //
        private void textBox1_Leave(object sender, EventArgs e)
        {
            if (textBox1.Text == "")
            {
                textBox1.Text = "Логин";
                textBox1.ForeColor = System.Drawing.Color.Gray;
            }
        }

        private void textBox1_Enter(object sender, EventArgs e)
        {
            if (textBox1.Text == "Логин")
            {
                textBox1.Clear();
                textBox1.ForeColor = System.Drawing.Color.Black;
            }
        }

        private void textBox2_Leave(object sender, EventArgs e)
        {
            if (textBox2.Text == "")
            {
                textBox2.Text = "Пароль";
                textBox2.ForeColor = System.Drawing.Color.Gray;
                textBox2.PasswordChar = '\0';
            }
        }

        private void textBox2_Enter(object sender, EventArgs e)
        {
            if (textBox2.Text == "Пароль")
            {
                textBox2.Clear();
                textBox2.ForeColor = System.Drawing.Color.Black;
                textBox2.PasswordChar = '•';
            }
        }

    }
}
