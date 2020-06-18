using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Log_in_Default : System.Web.UI.Page
{
    //CPANELUSERSSecu CCXC = new CPANELUSERSSecu();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnlogin_Click(object sender, EventArgs e)
    {
        try
        {


            UserAuthentication auth = new UserAuthentication();

            string username = name.Value.ToString().Trim().ToLower();
            string password = pass.Value.ToString().Trim();

            if (Tools.checkForSQLInjection(username) == true || Tools.checkForSQLInjection(password) == true)
                throw new Exception("Username or password is incorrect !");
            DataRow dt = auth.VERIFICATION_USER(username, password);
            if (dt == null) throw new Exception("Username or password is incorrect !");

            Session["username"] = dt["user_username"].ToString();
            Session["fullname"] = dt["user_fullname"].ToString();
            Session["role"] = dt["user_role"].ToString();
            Session["id_number"] = dt["user_id_number"].ToString();
            Session["id"] = dt["id"].ToString();

            FormsAuthentication.RedirectFromLoginPage(dt["user_username"].ToString(), true);
            auth.LOG(int.Parse(dt["id"].ToString()));
            Response.Redirect("~/cpanel/PC/Default.aspx");
        }
        catch (Exception xxx)
        {
            string script = "Swal.fire({ type: 'error', title: 'Oops...', text: '" + xxx.Message.ToString() + "' });";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
        }
        /*
         string us, p;
         us = name.Value.ToString().Replace("$", "").Replace("'", "").Replace("'", "").Replace("=", "").Replace("\"", "").Replace(" ", "").Replace(" ", "").Replace("\\", "").Replace("/", "").Replace(";", "");
         p = pass.Value.ToString().Replace("$", "").Replace("'", "").Replace("'", "").Replace("=", "").Replace("\"", "").Replace(" ", "").Replace(" ", "").Replace("\\", "").Replace("/", "").Replace(";", "");
         //  AAAK01.Text = us+ "    "+p;
         bool XXX = CCXC.CheckIDusernamepass(us, p);
         if (XXX)
         {
             DataSet KKK = CCXC.GetDataIDusernamepass(us, p);
             Session["userpublish"] = KKK.Tables[0].Rows[0]["TBunX51"].ToString();
             Session["userIDnumber"] = KKK.Tables[0].Rows[0]["TBidx51"].ToString();
             Session["userLevel"] = KKK.Tables[0].Rows[0]["TBkinX51"].ToString();
             Session["userFullname"] = KKK.Tables[0].Rows[0]["TBnaX51"].ToString();
             Session["userImage"] = KKK.Tables[0].Rows[0]["TBimageX51"].ToString();
             Application[KKK.Tables[0].Rows[0]["TBidx51"].ToString()] = KKK.Tables[0].Rows[0]["TBidx51"].ToString();
             FormsAuthentication.RedirectFromLoginPage(KKK.Tables[0].Rows[0]["TBunX51"].ToString(), true);
             CCXC.LoginInfoX6(Session["userpublish"].ToString());


             Response.Redirect("~/cpanel/PC/Default.aspx");


         }
         else
         {
             Label1.Text = "incorrect username or password. please try again";
             Label1.ForeColor = Color.Red;
             Label1.Font.Size = 12;
             //Response.Redirect("~/ErrorXX/try0XX21/index.html");
         }
         */
    }
}