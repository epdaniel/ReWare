<%@ Page Title="" Language="C#" MasterPageFile="~/cpanel/PC/MasterPage/ControPanel.master" AutoEventWireup="true" CodeFile="Redirect.aspx.cs" Inherits="pages002248Xc54_News022x_Redirect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta http-equiv="refresh" content="0; url=<%=Request.QueryString["url"] %>" />
<style>
/* Center the loader */
#loader {
  position: absolute;
  left: 55%;
  top: 50%;
  z-index: 999;
  width: 150px;
  height: 150px;
  margin: -75px 0 0 -75px;
  border: 16px solid #e6e6e6;
  border-radius: 50%;
  border-top: 16px solid #262f3d;
  width: 150px;
  height: 150px;
  -webkit-animation: spin 1s linear infinite;
  animation: spin 1s linear infinite;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}


</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_main" runat="Server">
    <div id="loader"></div>
</asp:Content>

