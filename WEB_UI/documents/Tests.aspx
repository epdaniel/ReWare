<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="Tests.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<title>Tests
	</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

	<h1><i class="fa fa-chevron-right p-1 "></i>Tests</h1>
	<hr />
	<a href="#unit_test" class="btn btn-dark btn-sm text-white" style="right: 0px !important;"></i>#UnitTests</a>
	<a href="#integration_tests" class="btn btn-sm btn-dark text-white" style="right: 0px !important;"></i>#IntegrationTests</a>
	<a href="#acceptance_tests" class="btn btn-sm btn-dark text-white" style="right: 0px !important;"></i>#AcceptanceTests</a>
	<section id="unit_test">
		<h4><i class="fa fa-circle p-1 m-3"></i>Unit Tests</h4>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Name/Description</th>
					<th scope="col">Goal</th>
					<th scope="col">Input</th>
					<th scope="col">Expected Result</th>
					<th scope="col">Actual Result</th>
					<th scope="col" style="width: 100px">Pass/fail</th>
				</tr>
			</thead>

			<tbody>
				<tr>
					<td>CNCtest_status</td>
					<td>check initial status of the cnc</td>
					<td>(void - None)</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNCtest_agents</td>
					<td>get - online agents in the system</td>
					<td>(void - None)</td>
					<td>{"status": true, "agents": [], "err_code": 0} / or agents.length > 0</td>
					<td>{"status": true, "agents": [], "err_code": 0} / or agents.length > 0</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNCtest_agents_validate_response</td>
					<td>check the response format -</td>
					<td>(void - None)</td>
					<td>{"status": true, "agents": [], "err_code": 0} / or agents.length > 0</td>
					<td>{"status": true, "agents": [], "err_code": 0} / or agents.length > 0</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNCtest_upload_Demo_malware</td>
					<td>upload malware to CNC (UI Function)</td>
					<td>(malware_exe ,malware_csv ,malware_json )</td>
					<td>{'status': True, 'id': //malware_id > 0}</td>
					<td>{'status': True, 'id': 157}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNCtest_upload_Null_File_malware</td>
					<td>upload malware to CNC (UI Function)</td>
					<td>(None,None,None)</td>
					<td>{'status': False, 'err_code': 500}</td>
					<td>{'status': False, 'err_code': 500}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNCtest_upload_None_File_malware</td>
					<td>upload malware to CNC (UI Function)</td>
					<td>None</td>
					<td>{'status': False, 'err_code': 500}</td>
					<td>{'status': False, 'err_code': 500}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNC-agent_stubtest_send_malware_to_agent</td>
					<td>send malware to agent</td>
					<td>(//malware_id , //agent_id)//(42,100)</td>
					<td>{"status": true, "err_code": 0, "msg": {"err_code": 0, "status": true}}</td>
					<td>{"status": true, "err_code": 0, "msg": {"err_code": 0, "status": true}}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNC-agent_stubtest_send_and_run_malware_to_agent</td>
					<td>Run Malware on agent</td>
					<td>(//malware_id , //agent_id)//(42,100)</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNC-agent_stubtest_send_run_Revert_malware_to_agent</td>
					<td>SendRunRevertMalware</td>
					<td>(//malware_id , //agent_id)//(42,100)</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_status</td>
					<td>Check that agent is alive</td>
					<td>None</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_upload_malware</td>
					<td>Upload a malware zip to the agent</td>
					<td>malware_id, malware_files</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_upload_same_malware</td>
					<td>Upload the same malware twice</td>
					<td>Callstest_upload_mlware twicewithout deleting</td>
					<td>Overrides previous files with new ones</td>
					<td>Overrides previous files with new ones</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_upload_bad_filetype_malware</td>
					<td>Upload a file which is not .zip to the agent</td>
					<td>malware_id,bad_malware_type</td>
					<td>{"status": false, "err_code": -10}</td>
					<td>{"status": false, "err_code": -10}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_upload_bad_malware_zip</td>
					<td>Upload a zip with missing files to agent</td>
					<td>malware_id,bad_malware_zip</td>
					<td>{"status": false, "err_code": -20}</td>
					<td>{"status": false, "err_code": -20}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_run_malware</td>
					<td>Run an uploaded malware on the agent</td>
					<td>malware_id</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_run_nonexistant_malware</td>
					<td>Try running a malware not uploaded to the agent</td>
					<td>malware_id</td>
					<td>{"status": false, "err_code": -404}</td>
					<td>{"status": false, "err_code": -404}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_revert_malware</td>
					<td>Revert a malware that has been run on the agent</td>
					<td>malware_id</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>{"status": true, "err_code": 0}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_revert_nonexistant_malware</td>
					<td>Try reverting a malware not uploaded to the agent</td>
					<td>malware_id</td>
					<td>{"status": false, "err_code": -404}</td>
					<td>{"status": false, "err_code": -404}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_read_malware_cs</td>
					<td>Read a csv file moved into csv_log folder</td>
					<td>malware_id</td>
					<td>True</td>
					<td>True</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_read_malware_csv_no_csv</td>
					<td>Try reading a csv when the folder is empty</td>
					<td>malware_id</td>
					<td>False</td>
					<td>False</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_run_malware_no_csv</td>
					<td>Try running a malware which does not create a csv</td>
					<td>malware_id</td>
					<td>{"status": false, "err_code": -100}</td>
					<td>{"status": false, "err_code": -100}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_get_logs</td>
					<td>Send API request to get recent logs from agent and inspect them (after running a malware)</td>
					<td>None</td>
					<td>‘Finished running malware successfully’ in last entry and other log tests</td>
					<td></td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_run_exe</td>
					<td>try to run an exe file</td>
					<td>exe_file: “text_exe.exe”</td>
					<td>{"status": True, "err_code": 0}</td>
					<td>{"status": True, "err_code": 0}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_read_exe_csv</td>
					<td>try to read a csv file of and exe</td>
					<td>malware id: 1file: POST</td>
					<td>True</td>
					<td>True</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>AGENTtest_read_exe_csv_no_csv</td>
					<td>try to read a csv file of an exe while there is no csv</td>
					<td>malware id: 1file: POST</td>
					<td>False</td>
					<td>False</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>Parsing data- file observable</td>
					<td>check the parsing of file observable</td>
					<td>CSV with lines describing file IOC</td>
					<td>IOC objects</td>
					<td>IOC objects</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>Parsing data- bad type</td>
					<td>check sad case</td>
					<td>csv with bad IOC type</td>
					<td>Exception</td>
					<td>Exception</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>Compile file observable code</td>
					<td>check the compilation process</td>
					<td>File IOC</td>
					<td>exe file of the IOC’s pre, in, post</td>
					<td>exes</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>Compile Dyre</td>
					<td>check compilation of large malware</td>
					<td>csv with dyre’s output</td>
					<td>exes of pre post and in of dyre</td>
					<td>exes</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>File observable reversion</td>
					<td>Check if the code of reverting file works</td>
					<td>File observable, file exists in system</td>
					<td>The file will be deleted</td>
					<td>the file was deleted</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>File observable revesion- SAD</td>
					<td>check what happens for non-existing file</td>
					<td>File observable, file doesn’t exist in the system</td>
					<td>Nothing should happen</td>
					<td>Nothing happend</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-PROCESStest_create_happy</td>
					<td>revert malware process creation</td>
					<td>none</td>
					<td>created process should not exist</td>
					<td>created process does not exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-PROCESStest_create_sad</td>
					<td>revert malware process creation when process already deleted</td>
					<td>none</td>
					<td>created process should not exist</td>
					<td>created process does not exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_create_happy</td>
					<td>revert malware file creation</td>
					<td>none</td>
					<td>created file should not exist</td>
					<td>created file does not exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_create_sad</td>
					<td>revert malware file creation, when user modified the file</td>
					<td>none</td>
					<td>created file should still exist</td>
					<td>created file exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_create_bad</td>
					<td>revert malware file creation, when the file does not exist</td>
					<td>none</td>
					<td>no exception thrown</td>
					<td>no exception thrown</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_delete_happy</td>
					<td>revert malware file deletion</td>
					<td>none</td>
					<td>deleted file should exist</td>
					<td>deleted file exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_delete_sad</td>
					<td>revert malware file deletion, malware did not complete</td>
					<td>none</td>
					<td>deleted file should exist</td>
					<td>deleted file exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_delete_bad</td>
					<td>revert malware file deletion, backup file corrupted</td>
					<td>none</td>
					<td>deleted file should remain deleted</td>
					<td>deleted file remain deleted</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_modify_happy</td>
					<td>revert malware file modification</td>
					<td>none</td>
					<td>modified file should be replaced</td>
					<td>modified file replaced</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_modify_sad</td>
					<td>revert malware file modification, but user modified it</td>
					<td>none</td>
					<td>modified file should not be replaced</td>
					<td>modified file did not get replaced</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Filetest_modify_bad</td>
					<td>revert malware file modification, but file got deleted</td>
					<td>none</td>
					<td>modified file should not exist</td>
					<td>modified file does not exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_create_happy</td>
					<td>revert malware registry creation</td>
					<td>none</td>
					<td>created key should be deleted</td>
					<td>created key deleted</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_create_sad</td>
					<td>revert malware registry creation, but the user modified it</td>
					<td>none</td>
					<td>created key should not be deleted</td>
					<td>created key not deleted</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_create_bad</td>
					<td>revert malware registry creation, but the key got deleted</td>
					<td>none</td>
					<td>created key should not exist</td>
					<td>created key does not exist</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_delete_happy</td>
					<td>revert malware registry deletion</td>
					<td>none</td>
					<td>deleted key should be restored</td>
					<td>deleted key restored</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_delete_sad</td>
					<td>revert malware registry deletion, but the user created a new one</td>
					<td>none</td>
					<td>deleted key should not be restored</td>
					<td>deleted key not restored</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_delete_bad</td>
					<td>revert malware registry deletion, but key did not exist</td>
					<td>none</td>
					<td>no exception</td>
					<td>no exception</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_modify_happy</td>
					<td>revert malware registry modification</td>
					<td>none</td>
					<td>modified key should be restored</td>
					<td>modified key restored</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_modify_sad</td>
					<td>revert malware registry modification, but user modified it after</td>
					<td>none</td>
					<td>modified key should not be restored</td>
					<td>modified key not restored</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>IOCS-Registrytest_modify_bad</td>
					<td>revert malware registry modification, but key does not exist</td>
					<td>none</td>
					<td>no exception</td>
					<td>no exception</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
			</tbody>
		</table>
	</section>

	<section id="integration_tests">
		<h4><i class="fa fa-circle p-1 m-3"></i>Integration Tests</h4>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Name/Description</th>
					<th scope="col">Goal</th>
					<th scope="col">Input</th>
					<th scope="col">Expected Result</th>
					<th scope="col">Actual Result</th>
					<th scope="col" style="width: 100px">Pass/Fail</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>CNC_AGENTsend malware to agent</td>
					<td>test send malware function</td>
					<td>(malware_id , agent_id)</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNC_AGENTsend malware to agent , run malware in agent</td>
					<td>test send & run function</td>
					<td>(malware_id , agent_id)</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
				<tr>
					<td>CNC_AGENTsend malware to agent , run malware in agent, revert malware in agent</td>
					<td>test send & run & revert functions</td>
					<td>(malware_id , agent_id)</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>{'status': True, 'err_code': 0, 'msg': '{"err_code": 0, "status": true}'}</td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
			</tbody>
		</table>
	</section>
	<section id="acceptance_tests">
		<h4><i class="fa fa-circle p-1 m-3"></i>Acceptance Tests</h4>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Name/Description</th>
					<th scope="col">Goal</th>
					<th scope="col">Input</th>
					<th scope="col">Expected Result</th>
					<th scope="col">Actual Result</th>
					<th scope="col" style="width: 100px">Pass/Fail</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Demo malware-simple</td>
					<td>Run full cycle from uploading, running and reverting malware</td>
					<td>Exe file of a simple malware emulation, csv describing it and json describing it </td>
					<td>Test should run with no exceptions, and no artifacts should be left behind </td>
					<td>As expected </td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>

				</tr>
				<tr>
					<td>Demo malware- user interfere</td>
					<td>Run full cycle from uploading, running and reverting malware, user edited an artifact generated by the malware emulator </td>
					<td>Exe file of a simple malware emulation, csv describing it and json describing it </td>
					<td>Test should run with no exceptions, artifact should be kept</td>
					<td>As expected </td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" />
					</td>
				</tr>
				<tr>
					<td>Ardamax-simple</td>
					<td>Run full cycle from uploading, running and reverting of real malware emulator- Ardamax</td>
					<td>Exe file of a simple malware emulation, csv describing it and json describing it </td>
					<td>Test should run with no exceptions, and no artifacts should be left behind </td>
					<td>As expected </td>
					<td>
						<img src="icons/pass.png" style="max-width: 30px" /></td>
				</tr>
			</tbody>
		</table>
	</section>


</asp:Content>

