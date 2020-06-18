<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="designdocument.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>ADD
    </title>
    <style>
        p {
            font-size: 1.2rem;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="width: 100%!important;">
        <table style="width: 100%!important;">
            <tr>
                <td style="width: 50%; text-align: left">
                    <h1><i class="fa fa-chevron-right p-1 "></i>App Design Document</h1>
                </td>
                <td style="width: 50%; text-align: right"><a target="_blank" href="https://docs.google.com/document/d/1WmKRXTS1s97bXETjsPMbC6YoeweX4symWVtkLE6iBk8/edit?usp=sharing" class="btn btn-primary text-white" style="right: 0px !important;"><i class="fa fa-download mr-2 "></i>PDF Download</a></td>
            </tr>
        </table>
    </div>
    <hr />
    <section>

        <meta charset="utf-8" />
        <b id="docs-internal-guid-7cbf03ef-7fff-16ff-383c-7defc8dc89f9" style="font-weight: normal;">
            <h1 dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;"><span style="font-size: 26pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Chapter 1 - Use Cases</span></h1>
            <h3 dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;"><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Use Case 1</span><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Execute Malware Emulator on agents’ machines</span></h3>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Primary Actor</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Experimental Environment</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Brief</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Experimental Environment asks the CNC to execute malware on certain agents.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Preconditions</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Required agents are alive and can communicate with the CNC, Required malware emulator is available.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Postconditions</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Required malware emulator has executed on all the required agents.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Triggers</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: HTTP request to the CNC server.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Basic Flow</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">:</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">1) Experimental Environment sends HTTP request to the CNC server requesting that a specific malware emulator run on a list of agents machines.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">2) The CNC acquires all the needed assets (malware emulator zip containing 3 executables- pre run, the malware emulator, post run) for the specific malware emulator to execute.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">3) The CNC sends the assets to each agent.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">4) Each agent sends a status change to the CNC signaling he is “RUNNING”.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">5) Each agents runs the pre.exe and then the malware.exe, in parallel each agents reads the csv file created by the pre and malware files and logs it locally</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">6) Each agent sends a status change to the CNC, to status “WAITING” and locally logs the run as successful</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">7) The CNC signals the Experimental Environment accordingly.</span>
            </p>
            <br />
            <h3 dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;"><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Use Case 2</span><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Add new malware emulator</span></h3>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Primary Actor</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Malware domain expert.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Brief</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: The malware domain expert wants to add new malware to the available malware emulator knowledge base.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Preconditions:</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;"> Malware domain expert’s computer has connection to the CNC.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Malware emulator is a python 2.7 file written with RTA (Red Team Automation).</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">CSV file describing the malware emulators true behavior.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">JSON file written in the STIX2 convention describing threat intelligence for the malware.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Postconditions:</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;"> The malware is available as an option to run in experiments.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Triggers</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Connection via HTML GUI to the CNC server, filling “add malware” form.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Basic Flow</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">:</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">1) Malware domain expert fills “add malware” form in the CNC server GUI, he chooses the python file, csv file and json file related to the malware emulator.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">2) The CNC server receives the files and stores them locally.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">3) The CNC server parses the csv file and creates files representing the malware emulators assets: 2 executables: pre.exe and post.exe.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">4) The CNC compiles the python file to an executable: malware.exe.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">5) The CNC zips all 3 executables (pre.exe, malware.exe, post.exe) stores it.</span>
            </p>
            <br />
            <h3 dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;"><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Uses Case 3</span><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: </span><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Revert malware execution</span></h3>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Primary Actor</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Agent.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Brief</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: after all the agents finished running the malware emulators assigned to them, and the Experiment Environment finished it’s part, it will require the reversion of the agents machines to the original state.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Preconditions</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: The Pre phase ran on the agents system.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">&nbsp;Malware emulator ran on the agents system.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">The Experimental Environment requested a reversion.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Postcondition</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: The agents machine is at the same state as it was prior to the malware emulator execution, except for legitimate user actions.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Basic Flow</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">:</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">1) The Experimental Environment requests a reversion from the CNC.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">2) The CNC requests reversion from each agent which participated in the experiment.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">3) Each agent sends a status change request to the CNC, to the status “REVERTING”</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">&nbsp;4) Each agent runs the “Post” executable.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">5) Each agent sends a status change request to the CNC, to the status “WAITING” and locally logs the revert as successful&nbsp;</span>
            </p>
            <br />
            <h3 dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;"><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Uses Case 4</span><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: </span><span style="font-size: 13.999999999999998pt; font-family: Arial; color: #434343; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Deploy malware to agent</span></h3>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Primary Actor</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: Experimental Environment</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Brief</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: after the malware(s) were uploaded to the CNC and compiled, we would like to deploy them to agents(s) so we could run them later on.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Preconditions</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: The malware was uploaded and compiled successfully to the CNC</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Malware emulator ran on the agents’ system.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Required agent(s) are alive and can communicate with the CNC</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Postcondition</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">: The agent(s) machine received the requested malware.</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: underline; -webkit-text-decoration-skip: none; text-decoration-skip-ink: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Basic Flow</span><span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">:</span>
            </p>
            <p dir="ltr" style="line-height: 1.284; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">1) The Experimental Environment requests an upload of a requested malware(s) to a requested agent(s) from the CNC.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">2) The CNC sends an upload request to each agent with the requested malware.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">3) Each agent receives the malware request with the malware files, unzipping and checking their integrity</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">4) Each agent sends a request to the CNC to update the DB that the malware was uploaded to the CNC successfully, also the successful upload is logged locally</span>
            </p>
        </b>
        <br class="Apple-interchange-newline" />

    </section>
    <section id="ch_2">

        <meta charset="utf-8" />
        <b id="docs-internal-guid-f0838fea-7fff-7523-f126-76e7ff100b6f" style="font-weight: normal;">
            <h1 dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;"><span style="font-size: 26pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 700; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Chapter 2 - System Architecture</span></h1>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">The system is comprised of 2 types of machines:</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">1) <span class="Apple-tab-span" style="white-space: pre;"></span>CNC server.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">2) <span class="Apple-tab-span" style="white-space: pre;"></span>Agent.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">A single CNC server is deployed to a local network.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Multiple agents can be deployed to the same local network.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">Each agent can receive a package of files, which it executes when required.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">The CNC creates said packages, and the main logic of the system is stored there.</span>
            </p>
            <p dir="ltr" style="line-height: 1.38; margin-top: 12pt; margin-bottom: 12pt;">
                <span style="font-size: 11pt; font-family: 'Miriam Libre',sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre; white-space: pre-wrap;">The communication can be bidirectional, as the CNC can start a session of malware emulator execution with each agent, Agent can transfer log information to the CNC.</span>
            </p>
        </b>
        <br class="Apple-interchange-newline" />
        <img src="imgs/image7.jpg" class="w-75" />
    </section>

    <section id="ch_3">
        <h2>Chapter 3 - Data Model</h2>
        <p>
            Local SQLite agent log:
        </p>
        <img src="imgs/image9.png" />

        <p>
            Created with SQLite to locally save log information, to be later retrieved by the CNC
            <br />

            <b>agent_id</b> - Agent’s id as saved in the CNC DB
            <br />
            <b>malware_id</b> - The malware id to which this data is related to, as saved in the CNC DB
            <br />
            <b>status</b> - The agent’s status (“WAITING”, “RUNNING”, “REVERTING”)<br />
            <b>time</b> - datetime in text form of the insertion of the row<br />
            <b>action_log</b> - a text of the action happening, taken from the malware’s CSV if the line signifies a read, otherwise will be just a text description<br />
            <b>csv_row_id</b> - The id of the row read from the CSV file if the line signifies a read, otherwise will be -1
            <br />

        </p>
        <p><b>Agent related tables in CNC MSSQL database:</b></p>
        <img src="imgs/image3.png" style="max-width: 100%" />
        <img src="imgs/image5.png" style="max-width: 100%" /><br />
        <b>Users(Table) , is created just for using the GUI , the administrator create a user that can upload malwares to the CNC via GUI , or run an malware on agent / data analysis (log) .</b>
    </section>
    <br />
    <section id="ch4" class="mt-2">
        <h2>Chapter 4 - Behavioral Analysis</h2>
        <div class="m-3">
            <b>4.1 Sequence diagram
            </b>
            <p>
                4.1.1 Agent state regarding execution stage:
The agent will have 3 states, one before the experiment starts, in which the agent should be able to receive new malware, once agent has malwares is can execute them.<br />
                After the agent starts execution, it shouldn’t be possible to receive new malwares.
                <br />

            </p>

            <img src="imgs/image17.jpg" style="max-width: 100%" /><br />

            <b>4.2 Events
            </b>
            <p>
                4.2.1 Use Case 1: Execute malware on agent
                <br />

            </p>

            <img src="imgs/image10.jpg" style="max-width: 100%" /><br />
            <p>
                4.2.2 Use Case 2: Add new malware emulator

                <br />

            </p>

            <img src="imgs/image14.jpg" style="max-width: 100%" />

        </div>
    </section>
    <section id="ch5">
        <br />
        <h2>Chapter 5 - Object-Oriented Analysis</h2>
        <b>5.1 Class Diagrams</b>
        <br />
        <b>Agent class diagram:</b><br />
        <img src="imgs/image6.png" style="max-width: 100%" />
        <br />
        <br />
        <b>Agent class diagram:</b>
        <br />
        <br />
        <img src="imgs/image4.png" style="max-width: 100%" /><br />

        <br />
        <b>5.2 - Class descriptions 
        </b>
        <br />
        <b>Agent:
        </b>
        <p>agent_main - runs the agent’s main function, sets basic configurations, connects to the CNC when needed, provides the necessary API methods for deploying running and reverting the malwares. </p>

        <a class="btn btn-primary text-white" href="/documents/Agentapi.aspx"><b>Agent Api</b></a>
        <br />
        <br />
        <b>CNC:</b>

        <p>cnc_main - runs the cnc main, set basic configurations, connects to the db, provides the necessary api methods.</p>

        <a class="btn btn-primary text-white" href="/documents/cncapi.aspx"><b>CNC Api</b></a>
        <br />
        <br />
        <b>5.3 - Packages</b>

        <p>
            agent package - includes all the necessary components for running the agent with runner class API.<br />
            cnc package - includes all the necessary components for running the cnc
        </p>

        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>app_code - cnc DB management classes.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>exceptions - cnc specific exceptions.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>iocs - iocs and operations classes.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>revert - revert handling classes and the compiler</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>STORAGE - malwares.</li>
        </ul>
        <p>WEB_UI package - GUI relevant classes for cnc web GUI.</p>
    </section>

    <section id="ch6">
        <br />
        <h2>Chapter 6 - User Interface</h2>
        <p>
            As we are working on a malware simulation system, the final product will be an API, that will be used by another system  to control and simulate the process of the malware on real user pc .
            <br />
            We built a web user interface for uploading malwares (to store a new malware in the CNC), and to show some information about the agents in the system.
        </p>
        <br />
        <img src="imgs/image88.jpg" style="max-width: 100%" />
        <br />

        <b>Log in page
            <br />
            (input : username , password )
            <br />
            Default - (admin,admin) </b>
        <br />
        <img src="imgs/image11.png" style="max-width: 100%" />
        <br />
        <br />
        <b>Home page: </b>
        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>Main menu : shows all the different pages with the functionality available to the user</li>
        </ul>

        <br />
        <img src="imgs/image13.png" style="max-width: 100%" />
        <br />
        <br />
        <b>Malwares page:  </b>
        <br />
        <p>
            Add button : the user can add a new malware by clicking on add button 
GridView - Malware table : shows the current malware that available in the cnc, 
        </p>
        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>title : malware name </li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>description : what the malware do</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>publisher L who upload the malware files ?</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>date</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>Status : Upload - the cnc received the malware  ,  Ready : the malware is ready to use / send to agent</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>Orange Button (Edit) : you can edit the malware name , or description </li>
        </ul>

        <br />
        <img src="imgs/image18.png" style="max-width: 100%" />
        <br />
        <br />
        <b>Agents page: </b>
        <br />
        <p>
            Refresh Button : update agents status - waiting for command (cloud) , (X) agent died , offline 
        </p>


        <br />
        <img src="imgs/image8.png" style="max-width: 100%" />
        <br />
        <br />
        <b>Add new Malware:  </b>
        <br />
        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>malware name </li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>malware description </li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>malware (exe) : the executable file of the malware</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>malware csv : csv file describing the malware’s actions and effects</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>malware json </li>
        </ul>
        <br />
        <img src="imgs/image15.png" style="max-width: 100%" />
        <br />
        <br />
        <b>Agent data:</b>
        <br />
        <br />
        <p>
            Adding new malware  : send a malware to agent by entering malware id and clicking on  the send button
            <br />
            <br />
            gridView - table : shows the malwares currently available on the agent (192.168.32.100)
            <br />
            Run button : clicking on this button will execute the malware in the agent 
            <br />
            <br />
            Revert button : clicking this button will revert the changes made by the malware 
            <br />
        </p>
        <br />
        <img src="imgs/image16.png" style="max-width: 100%" />
        <br />
        <br />
        <b>System Log: </b>
        <br />
        <p>via GUI , you can read the agent’s log remotely, it provides the following information about the agent machine: </p>
        <br />
        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>agent status , (online,offline,working - malware running , crash)</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>malware attack information (the changes that the malware made on the agent’s machine  - status for every step)</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>revert status - status for every step of the revert</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>detailed status for every step of the pre.exe</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>datetime for every entry</li>
        </ul>
        <br />
        <b>*Screenshot from malware log (From the GUI , Web interface) </b>
        <br />
        <br />
        <img src="imgs/image2.jpg" style="max-width: 100%" />
    </section>
    <br />
    <section id="ch7">
        <br />
        <h2>Chapter 7 - Testing
        </h2>
        <p>
            In order to test our system we will deploy it in a “Testbed” at DT, there we will make sure no harm is done to a working computer.
            <br />
            For each IOC type and operation combination, we will validate:

        </p>
        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>reversion is done and leaves no side effects.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>if the user changes the observable himself before the reversion is done, no reversion will take place.</li>

        </ul>
        <p>
            We will do this by creating automated procedures to imitate user activity and malware activity.
            <br />
            Additionally, once we are sure each type of IOC is dealt with correctly, we will check several real work scenarios as described in chapter 8.
            <br />
            <br />
            Unit tests and integration tests conducted and planned will be added to the appendix

        </p>
        <br />
        <p style="color: red">*  Attached : TestTable file</p>
        <a href="#" class="btn btn-primary">Tests PDF</a>
    </section><br />
      <section id="ch8">
        <br />
        <h2>Chapter 8 - Acceptance Scenarios
        </h2>
          <p>1. Run Dyre malware emulator- rather simple malware emulator, with simple steps.<br /><br />
2. Run Shamoon malware emulator- rather complicated malware emulator, including lateral movement.
              <br />
              3. Run Dyre and Shamoon malwares emulator- run both attacks on after the other
</p>
              <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>For each scenario create a script to change some of the observables the emulator touches, make sure the reversion doesn’t affect them.</li>


        </ul>
          <b>Actions of the malware emulators will be added as an appendix.</b>
      </section>


    <section id="ch9">
        <br />
        <h2>Appendix:
        </h2>
        <br />
        <b>Malware Assets:

        </b>
        <p>The malware files zip we send to the agent is called ‘malware assets’. This zip contains 3 files: </p>

        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>pre.exe - generated by the CNC, takes preservative action before running the malware, e.g backs up files/registries that will be changed by the malware</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>malware.exe - the malware emulator itself, as uploaded to the cnc</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>post.exe - generated by the CNC, reverts the actions made by the malware and restores the agent’s machine to its previous state</li>
        </ul>
        <p>
            These assets are saved in the agent folder: ‘C:\Users\Public\ReWare Agent’
Under this folder there will be a folder name temp - to hold temporary assets
Inside temp there will be folders with the id of the malware as the name containing it’s assets
        </p>
        <b>Agent Logs:</b>
        <p>The agent logs all of the relevant information regarding it’s run locally. This information could be found in the ‘agent.log’ txt file in the agent folder: ‘C:\Users\Public\ReWare Agent’
Or in the local db created by the agent, the db’s entries could be accessed by the CNC using the appropriate API call
</p>
        <b>Malware and executables CSV Logs:</b>
        <p>
            Each executable file generates a csv file logging it’s actions, their result along other useful information.<br />
CSV File format:

        </p>
        <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>HostName- The ip address of the machine in which the malware is running.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>DateTime- The timestamp in which the operation was created</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>IOCType- Type of IOC running- Currently supporting types: Folder, File, Port, Task, Registry, DNS.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>IOCPath- the location/value of the IOC</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>OperationType- Created/Modified/Deleted</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>OpResult- Completed/Failed</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>Info (optional) - further information regarding this operation (usually an error message)</li>
        </ul>
        <p>
            Malware emulator csv: this csv file will be generated in C:\csvlog folder with a random name, the agent takes and reads the first csv file in this folder
<br /><br />Executables csv: these csv files are generated in the agent folder: ‘C:\Users\Public\ReWare Agent’ under the sub folder ‘logs’. Each file name follows this structure: ‘{malware_id}_{filename}.csv’ (e.g: ‘11_POST.csv’)
        </p>
        <b>Supported IOCs types:</b>
                <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>Registry- windows global variables,used in almost all of windows applications.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>File- The file system, including directories.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>Process- Processes of windows system</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>Network- DNS requests, open ports.</li>

        </ul>
                <b>Supported Operations:</b>
                <ul class="fa-ul">
            <li class="m-3"><i class="fa-li fa fa-square"></i>Created- The malware created an artifact which didn’t exist before the malware’s execution.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>Deleted- The malware deletes an artifact which existed before the malware’s execution.</li>
            <li class="m-3"><i class="fa-li fa fa-square"></i>Modified- The malware changes the values of an artifact which existed before the malware’s execution.</li>


        </ul>
    </section>
     <a href="/documents/it2summary.aspx" class="btn btn-primary"><span>Iteration 2 Summary</span></a>
    <a href="/documents/it3summary.aspx" class="btn btn-primary"><span>Iteration 3 Summary</span></a>
 
</asp:Content>

