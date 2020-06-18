using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Agents
/// </summary>
public class Agents : DB_Connection
{
    public Agents()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataRow SELECT(int id)
    {
        string sql = string.Format("SELECT top 1 * FROM agents where id={0}", id);
        return GetDataSet(sql).Tables[0].Rows[0];
    }

}