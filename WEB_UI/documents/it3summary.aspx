<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="it3summary.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<title>Iteration 3 Summary
	</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


	<h1><i class="fa fa-chevron-right p-1 "></i>Iteration 3 Summary:</h1>
	<hr />
	<b><span style="font-size: 1.5rem">Documentation:</span></b>
	<p>ADD was updated to represent the current implementation.</p>
	<b><span style="font-size: 1.5rem">Agent Updates:</span></b>
	<div class="card  bg-dark text-white m-3">
		<div class="card-body">
			<ul class="fa-ul">
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added an API function to receive and run an exe file </li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Now reading csv files of pre.exe and post.exe, logging them locally to the agent.log file and the local db, for inspection when needed</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added unit tests for new features, refactored some old tests</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>General bug fixes</li>
			</ul>
		</div>
	</div>


	<b><span style="font-size: 1.5rem">CNC Updates:</span></b>
	<div class="card  bg-dark text-white m-3">
		<div class="card-body">
			<ul class="fa-ul">
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added logging for pre and post</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added an API function to send and run an exe file on agent</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Install SQL server on BGU Server</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Deploy and run CNC on BGU server</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>General bug fixes</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added acceptance tests</li>
			</ul>
		</div>
	</div>


	<b><span style="font-size: 1.5rem">IOC's Updates:</span></b>
	<div class="card  bg-dark text-white m-3">
		<div class="card-body">
			<ul class="fa-ul">
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added support for tasks, mutex</li>
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Refactored implementation for several IOCs</li>
			</ul>
		</div>
	</div>
	<b><span style="font-size: 1.5rem">Other:</span></b>
	<div class="card  bg-dark text-white m-3">
		<div class="card-body">
			<ul class="fa-ul">
				<li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added acceptance tests for Ardamax, Carberp, Powliks, Dyre</li>
			</ul>
		</div>
	</div>


</asp:Content>

