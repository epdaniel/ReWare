<%@ Page Title="" Language="C#" MasterPageFile="~/cpanel/PC/MasterPage/ControPanel.master" AutoEventWireup="true" CodeFile="log_activity.aspx.cs" Inherits="cpanel_PC_Administrative_Tools_log_activity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_main" runat="Server">
    <h2 style="display: inline; padding-left: 20px;">Log activity:</h2>
    <hr />
    <a href="Default.aspx" class="btn btn-success"><span>↩ Back</span></a>
    <asp:Button ID="btnClear" runat="server" Text="Clear"  class="btn btn-secondary" OnClick="btnClear_Click"/>
     <div style=" padding-top: 20px;">
        <asp:GridView ID="GR0021XX" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" Style="text-align: center" ForeColor="#333333" GridLines="None" PageSize="40">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="id" HeaderText="#" SortExpression="id" />
                <asp:BoundField DataField="ip_address" HeaderText="IPv4 Address" SortExpression="ip_address" />
                <asp:BoundField DataField="user_username" HeaderText="Username" SortExpression="user_username" />
                <asp:BoundField DataField="user_fullname" HeaderText="Name" SortExpression="user_fullname" ReadOnly="True" />
                <asp:BoundField DataField="datetime" HeaderText="Date" SortExpression="datetime" ReadOnly="True" />

            </Columns>
            <FooterStyle CssClass="table_header" />
            <HeaderStyle CssClass="table_header" />
            <RowStyle CssClass="table_row" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ReWareConnectionString %>" SelectCommand="SELECT user_fullname,user_username,ip_address,datetime,Log_activity.id as id FROM [Log_activity],[SystemUsers] where Log_activity.user_id=SystemUsers.id ORDER BY [Id] DESC"></asp:SqlDataSource>
    </div>
</asp:Content>

