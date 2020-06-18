<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="tutorials.aspx.cs" Inherits="documents_Agentapi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<style>
		b {
			font-size: 1rem
		}
	</style>
	<title>Tutorials</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<h1><i class="fa fa-chevron-right p-1 "></i>Tutorials</h1>
	<hr />
	<section>

		<div class="card    m-3">
			<div class="card-body">
				<b>ReWare tutorial : Demo malware </b>
				<ul class="fa-ul">
					<li class="m-2"><i class="fa-li fa fa-angle-right"></i>How to use the Web-GUI ?</li>
					<li class="m-2"><i class="fa-li fa fa-angle-right"></i>How to start the system ?</li>
					<li class="m-2"><i class="fa-li fa fa-angle-right"></i>How to upload malware to CNC ?</li>
					<li class="m-2"><i class="fa-li fa fa-angle-right"></i>How to send a malware to agent ?</li>
					<li class="m-2"><i class="fa-li fa fa-angle-right"></i>How to run the malware in agent ?</li>
					<li class="m-2"><i class="fa-li fa fa-angle-right"></i>How to revert the malware in agent ?</li>
					<li class="m-2"><i class="fa-li fa fa-angle-right"></i>More info ? <a href="/documents/usermanual.aspx#faq" class="btn btn-sm btn-dark text-white" style="right: 0px !important;">#FAQ</a></li>
					<li class="m-2">
						<div class="embed-responsive embed-responsive-16by9">
							<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/bzj-Hg5_i2A"></iframe>
						</div>
					</li>
				</ul>
			</div>
		</div>

		
	
	</section>
</asp:Content>

