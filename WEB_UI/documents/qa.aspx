<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="qa.aspx.cs" Inherits="documents_qa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<title>Q&A
	</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<h1><i class="fa fa-chevron-right p-1 "></i>Q&A (About ReWare)</h1>
	<hr />
	<p>got a question ? We're here to answer ! </p>
	<div id="disqus_thread"></div>
	<script>


(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://reware.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
	</script>
	<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>

</asp:Content>

