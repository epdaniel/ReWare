<%@ Page Title="" Language="C#" MasterPageFile="~/cpanel/PC/MasterPage/ControPanel.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="cpanel_PC_Administrative_Tools_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_main" runat="Server">
    <h2 style="display: inline; padding-left: 20px;">Settings</h2>
    <a href="Add.aspx" class="btn btn-primary" style="position: absolute; right: 5px; color: white;">Add</a>

    <hr />
    <a href="log_activity.aspx" class="btn btn-secondary"><span>Log activity</span></a>
    <asp:Button ID="btn_Erase_data" CssClass="btn btn-danger" runat="server" Text="Erase data" OnClientClick="return confirm('Are you sure?')" OnClick="btn_Erase_data_Click" />
   
    <div style="padding-top: 20px;">
        <asp:GridView ID="GR0021XX" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" Style="text-align: center" ForeColor="#333333" GridLines="None" PageSize="40">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="id" HeaderText="#" SortExpression="id" />
                <asp:BoundField DataField="user_fullname" HeaderText="Full Name" SortExpression="user_fullname" />
                <asp:BoundField DataField="user_username" HeaderText="Username" SortExpression="user_username" />
                <asp:BoundField DataField="user_id_number" HeaderText="ID number" SortExpression="user_id_number" ReadOnly="True" />

                <asp:BoundField DataField="user_role" HeaderText="Level" SortExpression="user_role" />
                <asp:TemplateField>
                    <ItemTemplate>

                        <a href="Edit.aspx?id=<%#Eval("id") %>" class="btn btn-warning"><span>Edit</span></a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle CssClass="table_header" />
            <HeaderStyle CssClass="table_header" />
            <RowStyle CssClass="table_row" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ReWareConnectionString %>" SelectCommand="SELECT * FROM [SystemUsers] ORDER BY [Id]"></asp:SqlDataSource>

    </div>
</asp:Content>

