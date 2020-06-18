<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Log_in_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ReWare System</title>
    <meta name="theme-color" content="#ffffff" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css" />
    <style type="text/css">
        .auto-style1 {
            width: 300px;
            height: auto;
        }

        .image-head {
            background-size: cover;
            background-repeat: no-repeat;
            background-position: top center;
            height: 500px;
            width: 100%;
            margin: 0;
            padding: 0;
            color: black;
            text-align: center;
        }
    </style>
</head>
<body runat="server" id="myimage" style="background-color:#2e2e2e; font-family: 'Roboto', sans-serif;">
    <form id="form1" runat="server">
        <div class="materialContainer">
            <div class="box">
                <div class="title">
                    <img class="auto-style1" src="../../IMG_SYS/LOGO_300.png" />
                </div>

                <div class="input">
                    <label for="name"></label>
                    <input runat="server" type="text" minlength="2" placeholder="Username" name="name" id="name" style="text-align: center;" required="required"/>
                    <span class="spin"></span>
                </div>

                <div class="input">
                    <label for="pass"></label>
                    <input runat="server" type="password" placeholder="Password" name="pass" id="pass" style="text-align: center;" required="required"/>
                    <span class="spin"></span>
                </div>

                <div style="height: 400px;">
                    <div style="height: 300px;"></div>
                    <asp:Button runat="server" ID="btnlogin" Style="width: 100%; height: 50px;" CssClass="btn btn-secondary" OnClick="btnlogin_Click" Text="Login"></asp:Button>
                </div>
                    <span  class="pass-forgot" style="font-size:16px;">© COPYRIGHTS RESERVED</span>
            </div>
        </div>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

        <script src="js/index.js"></script>
    </form>
</body>
</html>
