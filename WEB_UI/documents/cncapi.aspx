<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="cncapi.aspx.cs" Inherits="documents_Agentapi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        b {
            font-size: 1rem
        }
    </style>
     <title>CNC API</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1><i class="fa fa-chevron-right p-1 "></i>CNC API</h1>
    <hr />
		<a target="_blank" href="https://git.tlabs.bgu.ac.il/basslio/reware.git" class="btn btn-dark btn-sm text-white m-1" style="right: 0px !important;"><span data-feather="gitlab" class="mr-2"></span>Gitlab repository</a>
    <p>
        <b>cnc_main </b>- runs the cnc main, set basic configurations, connects to the db, provides the necessary api methods. 
    </p>
		
    <section>

        <b>cnc():</b>
        <ul class="fa-ul">
            <li class="m-2"><i class="fa-li fa fa-square"></i>Creates a thread that will run the flask app Sets up the cnc with the relevant fields.</li>
            <li class="m-2"><i class="fa-li fa fa-square"></i>return: thread</li>
        </ul>

        <p>

            <b>MalwareImporter</b> - for a given malware, define IOCs, compile and create relevant assets.
        </p>
        <b>create_assets():</b>
        <ul class="fa-ul">
            <li class="m-2"><i class="fa-li fa fa-square"></i>parse IOCs using IocParser, create the relevant assets in the computer, and Compile then using Compiler to create exe files of the IOCs and merge them to zip.</li>
            <li class="m-2"><i class="fa-li fa fa-square"></i>return: none</li>
            <li class="m-2"><i class="fa-li fa fa-square"></i>pre conditions: malware_id exists</li>
            <li class="m-2"><i class="fa-li fa fa-square"></i>post conditions: create malware zip in ‘storage_path’ input relative position.</li>
        </ul>

        <p>
            <b>abstractIOCs</b> - create IOCs using csv file. includes 4 different IOCs of which inherit from it.
        </p>

        <div class="card  bg-dark text-white m-3">
            <div class="card-body">
                <b>get_code_create(operation):</b>
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>returns: 3pule of (pre, in, post) code sections.</li>
                </ul>
            </div>
        </div>

        <b>CNC API - Flask:  
        </b>
        <div class="card  bg-dark text-white m-3">
            <div class="card-body">
                <b>@app.route('/uploader', methods=['GET', 'POST']) // Malware upload</b><br />
                usage:
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>post request :  http://CNC-ip:port/uploader</li>
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>data :   malware_name ,malware_description,malware_exe,malware_csv ,malware_json .</li>
                    <li class="m-2"><i class="fa-li fa fa-square"></i>return : { "status": True, "id": malware_id }</li>
                    <li class="m-2"><i class="fa-li fa fa-square"></i>error-occurred : { "status": False, "err_code": 500 }</li>
                </ul>
            </div>
        </div>
        <div class="card  bg-dark text-white m-3">

            <div class="card-body">
                <b>update all agents status (check if the agent online / offline : </b>
                <br />
                <b>@app.route('/')</b><br />
                usage:
                               <ul class="fa-ul">
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>get-request : http://CNC-ip:port/</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>return - None</li>

                               </ul>
            </div>
        </div>

        <div class="card  bg-dark text-white m-3">

            <div class="card-body">
                <b>get online agents : </b>
                <br />
                <b>@app.route('/agents') </b>
                <br />
                usage:
                               <ul class="fa-ul">
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>get-request : http://CNC-ip:port/agents</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>return : array (agents  ids) </li>

                               </ul>
            </div>
        </div>


        <div class="card  bg-dark text-white m-3">

            <div class="card-body">
                <b>Send malware to agent (CNC -> Agent):  </b>
                <br />
                <b>@app.route('/send_malware', methods=['GET'])</b>
                <br />
                usage:
                               <ul class="fa-ul">
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>get request :  http://CNC-ip:port/send_malware'</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>data :   malware_id(int),agent_id(int)</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>return : { "status": True/False, "err_code": 0/-1, "msg": null / error_description }</li>

                               </ul>
            </div>
        </div>

        <div class="card  bg-dark text-white m-3">

            <div class="card-body">
                <b>Run malware on agent (CNC -> Agent):</b>
                <br />
                <b>@app.route('/run_malware', methods=['GET'])</b>
                <br />
                usage:
                               <ul class="fa-ul">
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>get request :  http://CNC-ip:port/run_malware</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>data :   malware_id(int),agent_id(int)</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>return : { "status": True/False, "err_code": 0/-1, "msg": null / error_description }</li>

                               </ul>
            </div>
        </div>


        <div class="card  bg-dark text-white m-3">

            <div class="card-body">
                <b>Revert malware on agent (CNC -> Agent):</b>
                <br />
                <b>@app.route('/revert_malware', methods=['GET'])</b>
                <br />
                usage:
                               <ul class="fa-ul">
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>get request :  http://CNC-ip:port/revert_malware</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>data :   malware_id(int),agent_id(int)</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>return : { "status": True/False, "err_code": 0/-1, "msg": null / error_description }</li>

                               </ul>
            </div>
        </div>

        <div class="card  bg-dark text-white m-3">

            <div class="card-body">
                <b>Read log file from agent : </b>
                <br />
                <b>@app.route('/get_log_agent', methods=['GET'])</b>
                <br />
                usage:
                               <ul class="fa-ul">
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>get request :  http://CNC-ip:port/get_log_agent</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>data :   agent_id(int)</li>
                                   <li class="m-2"><i class="fa-li fa fa-angle-right"></i>return : { "status": True/False, "err_code": 0/-1, "id": agent_id, "msg": log_file.text }</li>

                               </ul>
            </div>
        </div>


    </section>
</asp:Content>

