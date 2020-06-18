using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cpanel_PC_Administrative_Tools_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false) { }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string[] categories = SendA.Value.Split(',');
              
            int user_id_number;
            if (int.TryParse(txtid.Value, out user_id_number) == false && txtid.Value.Length != 9) throw new Exception("User id number not correct !");
            int testphone;
            if (int.TryParse(txtphone1.Value, out testphone) == false && txtphone1.Value.Length >= 7) throw new Exception("Phone 1 not correct !");
            if (txtphone2.Value.Length > 0 && int.TryParse(txtphone2.Value, out testphone) == false && txtphone2.Value.Length >= 7) throw new Exception("Phone 2 not correct !");

            if (Tools.USERNAME_VALIDATOR(txtusername.Value) == false) throw new Exception("Please choose a valid username");


            int id = new UserAuthentication().INSERT_USER(user_id_number, txtfullname.Value, txtbirthdate.Value, txtphone1.Value, txtphone2.Value, txtusername.Value, txtpassword.Value, txtemail.Value, txtlevel.Value);
            new UserAuthentication().INSERT_CATEGORIES(categories, id);
            Response.Redirect("Default.aspx");


        }
        catch (Exception xxx)
        {
            string script = "Swal.fire({ type: 'error', title: 'Oops...', text: '" + xxx.Message.ToString() + "' });";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
        }
    }
}