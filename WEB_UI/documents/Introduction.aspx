<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="Introduction.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>
        Introduction
    </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

   
    <h1><i class="fa fa-chevron-right p-1 "></i>Introduction (About ReWare)</h1>
    <hr />

    <p>
        ReWare was conceived from a need to evaluate an innovative threat hunting framework that is developed at BGU university - called BICSAF.
    </p>
        
    <p>
        BICSAF (Bio Inspired Cyber Security Assurance Framework) - A joint research project from Cyber@BGU and NTU Singapore BICSAF's Main goal is to develop innovative technologies for tackling Advanced Persistent Threats (APTs).
    </p>
    <p> Evaluation is done by running "Malware Emulations"- list of steps meant to mimic the behavior of real malware, those emulator are written in Cyber@BGU, and although they mimic actions of real malwares, the effect is benign. </p>
    <p>ReWare will allow threat emulation on machines - agents, which are being actively used, without risk of dangerous side effects to the user's data.</p>
    <p>Additionally Reware will enable to run several experiments with no side effects between experiments. </p>
    <p> Reware manages the malware emulations and generate for each emulation pre-run and post-run packages which backups old data and revert users machine to previous state</p>
    <p>Each emulation is made up from list of steps- IOCs, which might leave artifact after the execution, this list is given to Reware as csv file when uploading new emulation, Reware then dynamically creates corresponding counter-steps</p>
    <p> Reware manages agents participating in the experiments and the execution of emulators on the agents. </p>
    <br />​
        <img src="imgs/it_systems2.png" class="rounded mx-auto d-block" style="max-width:100%" />
<br />​

</asp:Content>

