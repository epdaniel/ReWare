<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="Requirements.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Requirements
    </title>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h1><i class="fa fa-chevron-right p-1 "></i>Requirements</h1>
    <hr />
    <p>Functional requirements: </p>
    <ul class="fa-ul">
        <li class="m-3"><i class="fa-li fa fa-square"></i>Must allow managing (add, remove, update) malware emulators to the system.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Must expose API to run malware emulations on multiple systems.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Must expose API to revert malware emulations on multiple systems.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Log any events in order to ensure the success of the operation.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Malwares IOCs types to support: file, registry, mutex, network, process, task, lateral movement.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Malware IOCs operations to support: deleted, created, modified.</li>
    </ul>
    <p>Non-functional requirements</p>
    <ul class="fa-ul">
        <li class="m-3"><i class="fa-li fa fa-square"></i>After reverting a malware emulations run, the system should behave and have artifacts as if no malware emulations was running.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Addition of new IOC types should be easy for a developer.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Addition of new malware emulations should be easy.</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Network traffic of the system should be minimal when experiment is running</li>
        <li class="m-3"><i class="fa-li fa fa-square"></i>Logging should be done locally and globally</li>
    </ul>

   
</asp:Content>

