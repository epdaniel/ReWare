﻿<%@ Page Title="" Language="C#" MasterPageFile="~/cpanel/PC/MasterPage/ControPanel.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="cpanel_PC_Administrative_Tools_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function get_selected_catogires() {
            var favorite = [];
            $.each($("input[name='categories']:checked"), function () {
                favorite.push(parseInt($(this).val()));
            });

            return favorite;
        }

        function Run() {

            document.getElementById("<%=SendA.ClientID%>").value = get_selected_catogires();
                document.getElementById('<%= btnSave.ClientID %>').click();

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_main" runat="Server">
    <%
        int id = int.Parse(Request.QueryString["id"].ToString());
        System.Data.DataRow dt = new UserAuthentication().SELECT_USER(id);
        txtid.Value = dt["user_id_number"].ToString();
        txtfullname.Value = dt["user_fullname"].ToString();
        txtbirthdate.Value = dt["user_birthday"].ToString();
        txtphone1.Value = dt["user_phone1"].ToString();
        txtphone2.Value = dt["user_phone2"].ToString();
        txtemail.Value = dt["user_email"].ToString();
        txtlevel.Value = dt["user_role"].ToString();
        txtpassword.Value = dt["user_hash"].ToString();
        txtusername.Value = dt["user_username"].ToString();


    %>

    <asp:HiddenField ID="SendA" runat="server" />
    <h2 style="display: inline; padding-left: 20px;">Edit (<%= id %>):</h2>
    <hr />
    <a href="Default.aspx" class="btn btn-success"><span>↩ Back</span></a>
    <div style="padding-left: 30px; padding-top: 20px;">
        <table style="width: 400px;" align="Left">
            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">ID (ת"ז):</span>
                        </div>
                        <input type="Text" maxlength="9" minlength="9" runat="server" id="txtid" class="form-control" placeholder="ex : 123456789" style="text-align: center;" required readonly>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Full name:</span>
                        </div>
                        <input type="Text" minlength="2" runat="server" id="txtfullname" class="form-control" placeholder="שם מלא" style="text-align: center;" required>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Phone 1:</span>
                        </div>
                        <input type="tel" minlength="7" maxlength="10" runat="server" id="txtphone1" class="form-control" placeholder="מספר טלפון 1" style="text-align: center;" required>
                    </div>
                </td>
            </tr>


            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Phone 2:</span>
                        </div>
                        <input type="tel" minlength="7" maxlength="10" runat="server" id="txtphone2" class="form-control" placeholder="מספר טלפון 2" style="text-align: center;">
                    </div>
                </td>
            </tr>


            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Email :</span>
                        </div>
                        <input type="email" runat="server" class="form-control" id="txtemail" placeholder="info@GetBagrut.com" style="text-align: center;">
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">BirthDay:</span>
                        </div>
                        <input type="Date" runat="server" class="form-control" id="txtbirthdate" placeholder="תאריך לידה" style="text-align: center;">
                    </div>
                </td>
            </tr>

            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">@ Username:</span>
                        </div>
                        <input type="Text" minlength="2" runat="server" class="form-control" id="txtusername" placeholder="שם משתמש" style="text-align: center;" required readonly>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">@ Password :</span>
                        </div>
                        <input type="Text" minlength="6" runat="server" class="form-control" id="txtpassword" placeholder="******" style="text-align: center;" required>
                    </div>
                </td>
            </tr>


            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Level:</span>
                        </div>
                        <select class="custom-select" id="txtlevel" runat="server">
                            <option selected>Other</option>
                            <option value="Admin">Admin</option>
                        </select>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <label class="col-form-label">Permission (הרשאות)<span style="color: red">*</span>:</label>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SystemCategories">
                            <ItemTemplate>
                                <div class="input-group " style="padding-bottom: 10px;">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="checkbox" name="categories" value="<%#Eval("Id") %>" <%#Eval("User_id").ToString().Trim().Length == 0 ? "" : "checked"   %>>
                                        </div>
                                    </div>
                                    <input type="text" class="form-control" value='<%#Eval("Category_name") %>' readonly>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="SystemCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ReWareConnectionString %>" SelectCommand="SELECT * FROM SystemCategories LEFT JOIN ControlPanelUsersCategories ON (SystemCategories.id=ControlPanelUsersCategories.Category_id  and User_id=@id)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </td>
            </tr>

            <tr>

                <td style="text-align: right">
                    <asp:Button ID="btnDelete" Style="position: relative; right: 280px;" runat="server" Text="Delete" CssClass="btn btn-md btn-danger" OnClick="btnDelete_Click" />
                    <input type="button" class="btn btn-md btn-warning" onclick="Run()" value="Save" />
                    <asp:Button ID="btnSave" Style="display: none;" runat="server" Text="Save" CssClass="btn btn-md btn-warning" OnClick="btnSave_Click" />

                </td>
            </tr>
        </table>
    </div>
</asp:Content>

