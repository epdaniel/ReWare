using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cpanel_PC_Administrative_Tools_Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            int id = int.Parse(Request.QueryString["id"].ToString());
            new UserAuthentication().DELETE_ACCOUNT(id);
            Response.Redirect("Default.aspx");
        }
        catch (Exception xxx)
        {
            string script = "Swal.fire({ type: 'error', title: 'Oops...', text: '" + xxx.Message.ToString() + "' });";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Tools.USERNAME_VALIDATOR(txtusername.Value) == false) throw new Exception("Please choose a valid username");
            int id = int.Parse(Request.QueryString["id"].ToString());
            string[] categories = SendA.Value.Split(',');
            int testphone;
            if (int.TryParse(txtphone1.Value, out testphone) == false && txtphone1.Value.Length >= 7) throw new Exception("Phone 1 not correct !");
            if (txtphone2.Value.Length > 0 && int.TryParse(txtphone1.Value, out testphone) == false && txtphone2.Value.Length >= 7) throw new Exception("Phone 1 not correct !");
            new UserAuthentication().UPDATE_USER(id, txtfullname.Value, txtbirthdate.Value, txtphone1.Value, txtphone2.Value, txtusername.Value, txtpassword.Value, txtemail.Value, txtlevel.Value, categories);
            Response.Redirect("Default.aspx");
        }
        catch (Exception xxx)
        {
            string script = "Swal.fire({ type: 'error', title: 'Oops...', text: '" + xxx.Message.ToString() + "' });";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
        }

    }
}