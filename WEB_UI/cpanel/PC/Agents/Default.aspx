<%@ Page Title="" Language="C#" MasterPageFile="~/cpanel/PC/MasterPage/ControPanel.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="cpanel_PC_Agents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_main" Runat="Server">
    <asp:Button ID="reload_data_grideview" runat="server" style="display:none" OnClick="reload_data_grideview_Click" />
        <script>
        function check_agents() {
      Swal.fire({
            title: 'Please Wait',
            allowEscapeKey: false,
            allowOutsideClick: false,
            background: '#19191a',
            showConfirmButton: false,
            onOpen: ()=>{
                Swal.showLoading();
            }

            // timer: 3000,
            // timerProgressBar: true
        });

            $.ajax({
                url: '<%=System.Configuration.ConfigurationManager.AppSettings["CNC_SERVER"]%>',
                method: 'GET',
                data: [],
                success: function (data) {
                    console.log('ok');
            
                       document.getElementById("<%=reload_data_grideview.ClientID %>").click();
                },

                error: function () {
                    console.log('error');
                     Swal.fire(
                        'Something wrong !',
                        'Server is not reachable !',
                        'error'
                    )
                }
            });
        }
    </script>
    <h2 style="display: inline; padding-left: 20px;">Agents :</h2>
    <hr />
    <a href="Default.aspx" class="btn btn-success"><span>↩ Back</span></a>
  
     <input type="button" ID="btn_check_status"  class="btn btn-info" OnClick="check_agents()"  value="Refresh (Status)"/>
    <div style="padding-top: 20px;">
        <asp:GridView ID="GR0021XX" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" Style="text-align: center" ForeColor="#333333" GridLines="None" PageSize="40">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="id" HeaderText="#" SortExpression="id" />
                <asp:BoundField DataField="Host_Name" HeaderText="Host_Name" SortExpression="Host_Name" />
                <asp:BoundField DataField="IP" HeaderText="IP Address" SortExpression="IP" />
                <asp:BoundField DataField="port" HeaderText="Port" SortExpression="port" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <img style="width:40px; height:40px;" src="img/<%#Eval("Status") %>.png" />
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField DataField="last_updated" HeaderText="Last update" SortExpression="last_updated" ReadOnly="True" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <a href="cmd.aspx?id=<%#Eval("id") %>" class="btn btn-warning"><span>..</span></a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle CssClass="table_header" />
            <HeaderStyle CssClass="table_header" />
            <RowStyle CssClass="table_row" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ReWareConnectionString %>" SelectCommand="SELECT * FROM [Agents] ORDER BY case  when status='WAITING' then 1 when status='RUNNING' then 2 else 3 end "></asp:SqlDataSource>
    </div>
   
<br />

</asp:Content>

