using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Flurl.Http;

public partial class cpanel_PC_Agents_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    public async System.Threading.Tasks.Task getCNC_status() {
        var responseString = await  System.Configuration.ConfigurationManager.AppSettings["CNC_SERVER"].ToString()
            .GetStringAsync();
       
      
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            var responseString = string.Format(System.Configuration.ConfigurationManager.AppSettings["CNC_SERVER"].ToString())
                .GetStringAsync();

            string v = responseString.Result;
            GR0021XX.DataBind();
        }
        catch (Exception xxx)
        {
            string script = "Swal.fire({ type: 'error', title: 'Oops...', text: '" + "CNC Server is not reachable" + "' });";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
        }


    }

    protected void reload_data_grideview_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }
}