<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="maintenanceguide.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<title>Maintenance guide
	</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

	<h1><i class="fa fa-chevron-right p-1 "></i>Maintenance guide</h1>
	<hr />
	<p>1.	Supporting new IOCs:</p>
	<ul class="fa-ul">
		<li class="m-3"><i class="fa-li fa fa-square"></i>1.1.	If a new malware emulator is to be imported it’s important that the Reware system will support all the IOCs of the new malware.</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>1.2.	When adding new malware, it is important to check that all the IOCs are of supported types and operations, if they are not supported, one can add with relative ease new types by adding python code.</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>1.3.	Each IOC class should implement the abstract class AbstractIOC.</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>1.4.	Relevant files and folders:

			<ul class="fa-ul">
				<li class="m-3"><i class="fa-li fa fa-square"></i>1.4.1.	Cnc\revert\code_template.py- contains a template of all the common functionality for each phase, for example, to add an additional library, add the import line to this file.</li>
				<li class="m-3"><i class="fa-li fa fa-square"></i>1.4.2.	 cnc\ioc_parser.py- contains a map from IOC type to IOC class, when implementing new types, add the relevant entry to the map.</li>
				<li class="m-3"><i class="fa-li fa fa-square"></i>1.4.3.	cnc\iocs- folder contains current implementations of IOCs.</li>
			</ul>

		</li>
	</ul>
	<p>2.	Malware management UI:</p>
	<ul class="fa-ul">
		<li class="m-3"><i class="fa-li fa fa-square"></i>2.1.	If a need rises to change/add functionality to the UI, the UI elements are built with ASP.NET and are located in: WEB_UI folder.</li>
	</ul>
	<p>3.	Agent local files:</p>
	<ul class="fa-ul">
		<li class="m-3"><i class="fa-li fa fa-square"></i>3.1.	When the agent program is running on the host, it can create some temporary files for things like backups and local log, those files are located by default at C:\Users\Public\ReWare Agent</li>
	</ul>
	<p>4.	More:</p>
	<ul class="fa-ul">
		<li class="m-3"><i class="fa-li fa fa-square"></i><a href="/documents/cncapi.aspx" class="btn btn-dark btn-sm text-white" style="right: 0px !important;"></i>CNC api code explanation</a></li>
		<li class="m-3"><i class="fa-li fa fa-square"></i><a href="/documents/Agentapi.aspx" class="btn btn-dark btn-sm text-white" style="right: 0px !important;"></i>Agent api code explanation</a></li>
		<li class="m-3"><i class="fa-li fa fa-square"></i><a target="_blank" href="https://git.tlabs.bgu.ac.il/basslio/reware.git" class="btn btn-dark btn-sm text-white" style="right: 0px !important;"></i>Gitlab repository</a></li>
	</ul>
</asp:Content>

