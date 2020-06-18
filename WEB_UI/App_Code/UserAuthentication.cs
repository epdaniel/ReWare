using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

/// <summary>
/// © copyright reserved , shadi fadila 2020/2019 , 13/08/2019 
/// </summary>
public class UserAuthentication : DB_Connection
{
    public UserAuthentication()
    {

    }
    public void INSERT_CATEGORIES(string[] categroies, int userid)
    {
        if (categroies.Length == 0) return;
        string tuples = "";
        foreach (string cat in categroies)
        {
            int x;
            if (int.TryParse(cat, out x) == false) throw new Exception("ERROR");
            tuples = tuples + " " + string.Format("({0},{1})", cat, userid);
        }
        tuples = tuples.Trim().Replace(" ", ",");
        string str = string.Format("INSERT INTO ControlPanelUsersCategories(Category_id,User_id) VALUES {0}", tuples, userid);
        ExecuteNonQuery(str);
    }

    public int INSERT_USER(int ID_number, string fullname, string birthday, string phone1, string phone2, string username, string hash, string email, string role)
    {
        username = username.ToLower().Trim();
        string str = string.Format("INSERT INTO SYSTEMUSERS(USER_ID_NUMBER,USER_FULLNAME,USER_BIRTHDAY,USER_PHONE1,USER_PHONE2,USER_USERNAME,USER_HASH,USER_EMAIL,USER_ROLE) OUTPUT Inserted.id as row_id VALUES(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}')", ID_number, fullname, birthday, phone1, phone2, username, hash, email, role);
        return int.Parse(GetDataSet(str).Tables[0].Rows[0]["row_id"].ToString());

    }
    //id=row_id
    public void UPDATE_USER(int id, string fullname, string birthday, string phone1, string phone2, string username, string hash, string email, string role, string[] categories)
    {
        username = username.ToLower().Trim();
        string str = string.Format(@"DELETE FROM ControlPanelUsersCategories WHERE User_id={0} ;
                                                               UPDATE  [SystemUsers] SET 
                                                               USER_FULLNAME=N'{1}' ,
                                                               USER_BIRTHDAY=N'{2}' ,
                                                               USER_PHONE1=N'{3}' ,
                                                               USER_PHONE2=N'{4}' ,
                                                               USER_USERNAME=N'{5}',
                                                               USER_HASH=N'{6}',
                                                               USER_EMAIL=N'{7}' ,
                                                               USER_ROLE=N'{8}' where id={0} ", id, fullname, birthday, phone1, phone2, username, hash, email, role);
        ExecuteNonQuery(str);
        INSERT_CATEGORIES(categories, id);
    }

    public DataRow SELECT_USER(int id)
    {
        string SQL = string.Format("SELECT * FROM SystemUsers where id={0} ", id);
        return GetDataSet(SQL).Tables[0].Rows[0];
    }

    /************Log_activity******(START)*******/
    /************Log_activity******(START)*******/
    protected string GET_iP()
    {
        string VisitorsIPAddr = string.Empty;
        if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
        {
            VisitorsIPAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
        }
        else if (HttpContext.Current.Request.UserHostAddress.Length != 0)
        {
            VisitorsIPAddr = HttpContext.Current.Request.UserHostAddress;
        }
        return VisitorsIPAddr;
    }
    public void LOG(int user_id)
    {
        string str = string.Format("Insert Into Log_activity(ip_address,user_id) Values(N'{0}',{1})", GET_iP(), user_id);
        ExecuteNonQuery(str);
    }

    /************Log_activity******(END)*******/
    /************Log_activity******(END)*******/
    ///////////////////////HELPER FUNCTION
    public DataRow SELECT_USER_USERNAME(string USERNAME)
    {
        string str = string.Format("SELECT top 1 * FROM [SystemUsers] where  user_username=N'{0}'", USERNAME);
        return GetDataSet(str).Tables[0].Rows[0];
    }
    public DataRow SELECT_USER_ID(int row_id)
    {
        string str = string.Format("SELECT top 1 * FROM [SystemUsers] where  id=N'{0}'", row_id);
        return GetDataSet(str).Tables[0].Rows[0];
    }
    public DataRow VERIFICATION_USER(string username, string hash)
    {
        string str = string.Format("SELECT * FROM [SystemUsers] where user_username=N'{0}' and user_hash=N'{1}'", username.ToLower(), hash);
        DataSet dt = GetDataSet(str);
        if (dt.Tables[0].Rows.Count == 0) return null;
        return GetDataSet(str).Tables[0].Rows[0];
    }
    /////////////////////// DELETE
    public void DELETE_ACCOUNT(int id)
    {
        string str2 = string.Format("Delete from SystemUsers where id={0} ; BCC CHECKIDENT (SystemUsers, RESEED, 0); ", id);
        ExecuteNonQuery(str2);
    }
    public void DELETE_LOG_ACTIVITY()
    {
        string str2 = string.Format("Delete  from Log_activity");
        ExecuteNonQuery(str2);
    }
}

