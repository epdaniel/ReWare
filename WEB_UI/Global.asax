<%@ Application Language="C#" %>
<%@ Import namespace="System.Web.Http" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="System.Net.Http.Formatting" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="Newtonsoft.Json.Serialization" %>
<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        //http://10.0.0.17/api/MyApi/Reservation_Validation/0538241788
        // Code that runs on application startup
        RouteTable.Routes.MapHttpRoute("DefaultApi", "api/{controller}/{Action}/{id}", new { id = System.Web.Http.RouteParameter.Optional });
        GlobalConfiguration.Configuration.Formatters.Clear();
        // GlobalConfiguration.Configuration.Formatters.JsonFormatter.SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/octet-stream"));
        GlobalConfiguration.Configuration.Formatters.Add(new JsonMediaTypeFormatter
        {
            SerializerSettings = new JsonSerializerSettings
            {
               
                Formatting = Formatting.None,
                DateFormatHandling = DateFormatHandling.IsoDateFormat,
                NullValueHandling = NullValueHandling.Include,
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                ContractResolver = new CamelCasePropertyNamesContractResolver(),
            }
        });
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
