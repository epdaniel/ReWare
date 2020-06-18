using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cpanel_PC_Administrative_Tools_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_Erase_data_Click(object sender, EventArgs e)
    {
        new UserAuthentication().EraseData();
    }
}