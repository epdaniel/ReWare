<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Log.aspx.cs" Inherits="cpanel_PC_Agents_Log" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agent Log</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <style>
        h1, h2, h3, h4, h5, h6, span {
            color: white;
            font-family: Arial;
        }

        .log {
            font-size: 14px;
            font-family: Consolas;
        }
        .time{
            color:#71bb12;
        }
        .status{
            color:#8159e5;
            font-weight:700;
        }
    </style>

    <script>
        var doc;
        function state_machine(_agent_id) {

            Swal.fire({
                title: 'Please Wait',
                allowEscapeKey: false,
                allowOutsideClick: false,
                background: '#19191a',
                showConfirmButton: false,
                onOpen: () => {
                    Swal.showLoading();
                }
            });

            $.ajax({
                url: '<%=System.Configuration.ConfigurationManager.AppSettings["CNC_AGENT_LOG"].ToString() %>',
                method: 'GET',
                data: { agent_id: _agent_id },
                success: function (data) {
                    data = JSON.parse(data);
                    console.log(data);
                    if (data.status == true) {
                        data = JSON.parse(data.msg);
                        console.log(data);

                        data.forEach(element => {

                            document.getElementById("log").innerHTML += "<div id='foo'><span class='log'><span class='time'>" + element[4] + "</span>\xa0\xa0\xa0\xa0<span class='status'>" + element[3] + "</span>\xa0\xa0\xa0\xa0\xa0\xa0\xa0<span>" + element[5] + "</span></span></div>";
                        });
                        swal.close()
                        return;
                    }

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

    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
</head>
<body style="background-color: black">
    <form id="form1" runat="server">
        <h3>
            <img src="/IMG_SYS/LOGO_300.png" style="width: 200px;" /></h3>
        <small style="color: white;">AGENT ID : <%=Request.QueryString["id"].ToString() %></small>
        <div id="log">
        </div>

        <script>
            state_machine('<%=Request.QueryString["id"].ToString() %>')
        </script>
    </form>
</body>
</html>
