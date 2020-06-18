import pyodbc


class db_connection:
    mydb = None

    def __init__(self):
        try:
            self.mydb = pyodbc.connect('Driver={SQL Server};'
                                       'Server=132.72.81.38\SQLEXPRESS;'
                                       'Database=reware;'
                                       'uid=reware;pwd=1q2w#E$R;'
                                       'Integrated Security=true;')

            print("connection to database established")
        except:
            print("connection to database failed")

    def execute(self, sql, val):
        self.mydb.cursor().execute(sql, val)
        self.mydb.commit()
        self.mydb.close()

    def execute(self, sql):
        self.mydb.cursor().execute(sql)
        self.mydb.commit()
        self.mydb.close()

    def get_data(self, sql):
        mycursor = self.mydb.cursor()
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        self.mydb.commit()
        self.mydb.close()
        return myresult

    def test_connection(self):
        print(self.mydb)
