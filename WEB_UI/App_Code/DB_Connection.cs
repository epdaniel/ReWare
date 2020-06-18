using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// © copyright reserved , shadi fadila 2019 
/// </summary>
public abstract class DB_Connection
{
    protected SqlConnection conn;
    private SqlCommand cmd;
   
    protected DB_Connection()
    {
        cmd = new SqlCommand();
        conn = new SqlConnection();
        conn.ConnectionString = @"Data Source=132.72.81.38\SQLEXPRESS;Initial Catalog=reware;Persist Security Info=True;User ID=reware;Password=1q2w#E$R";

    }
    protected DataSet GetDataSet(string SqlStr)
    {
        
            DataSet ds = new DataSet();
            cmd.CommandText = SqlStr;
            cmd.Connection = conn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            return ds;
       
    }
    protected void ExecuteNonQuery(string sql)
    {
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
            conn.Close();
    }
    public void EraseData() {
        string sql = @"

DELETE FROM Agents;
DELETE FROM Agent_malwares;
DELETE FROM Agents_logs;
DELETE FROM Log_activity;
DELETE FROM Malwares;
truncate table Agent_malwares;
truncate table Agents_logs;
truncate table Log_activity;
DBCC CHECKIDENT ('reware.dbo.Malwares',RESEED, 0)
DBCC CHECKIDENT ('reware.dbo.Agents',RESEED, 0)
        ";
        ExecuteNonQuery(sql);

    }
   
    
}