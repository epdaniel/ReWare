<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="team.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<title>Team
	</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


	<h1><i class="fa fa-chevron-right p-1 "></i>Team:</h1>
	<hr />

	<div class="card m-4" style="width: 18rem; display: inline-block">
		<img class="card-img-top" src="/documents/imgs/daniel.png" alt="Card image cap">
		<div class="card-body">
			<h5 class="card-title">Daniel Epshtein</h5>
			<h6 class="card-subtitle mb-2 text-muted">danielep@post.bgu.ac.il</h6>
			<p class="card-text">
				Agent side application (API)<br />
				Agent DataBase
                <br />
				Project Website
			</p>

		</div>
	</div>
	<div class="card m-4" style="width: 18rem; display: inline-block">
		<img class="card-img-top" src="/documents/imgs/shadi.jpg" alt="Card image cap">
		<div class="card-body">
			<h5 class="card-title">Shadi Fadila</h5>
			<h6 class="card-subtitle mb-2 text-muted">fadila@post.bgu.ac.il</h6>
			<p class="card-text">
				CNC side application (API)<br />
				Web-GUI for CNC
                <br />
				Project Website
			</p>

		</div>
	</div>

	<div class="card m-4" style="width: 18rem; display: inline-block">
		<img class="card-img-top" src="/documents/imgs/lior.jpg" alt="Card image cap">
		<div class="card-body">
			<h5 class="card-title">Lior Bass</h5>
			<h6 class="card-subtitle mb-2 text-muted">basslio@post.bgu.ac.il</h6>
			<p class="card-text">
				Malware Parser<br />
				Reversion compiler
                <br />
				IOC's 
			</p>
		</div>
	</div>



	<div class="card m-4" style="width: 18rem; display: inline-block; vertical-align:top">
		<img class="card-img-top" src="/documents/imgs/liam.png" alt="Card image cap">
		<div class="card-body">
			<h5 class="card-title">Liam Cohen</h5>
			<h6 class="card-subtitle mb-2 text-muted">liamc@post.bgu.ac.il</h6>
			<p class="card-text">
				Reversion compiler
                <br />
				IOC's <br />
			</p>
		</div>
	</div>



</asp:Content>

