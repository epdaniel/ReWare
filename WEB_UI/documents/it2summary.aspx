<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="it2summary.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>
       Iteration 2 Summary
    </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

   
    <h1><i class="fa fa-chevron-right p-1 "></i>Iteration 2 Summary</h1>
    <hr />
    <b><span style="font-size:1.5rem">Deployment:</span></b>
    <p>We received a VM in the labs, in which we installed our CNC.<br />
We did try to run our setup at the testbed at the labs, where it did run.
</p>

     <b><span style="font-size:1.5rem">  Documentation:</span></b>
 <p>ADD was updated to represent the current implementation.<br />
An appendix was added to the documentation, describing assumptions taken on the malware emulators and other necessary information.</p>
    <b><span style="font-size:1.5rem"> CNC Updates:</span></b>



        <div class="card  bg-dark text-white m-3">
            <div class="card-body">
                <b>SQL Server :</b>
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>All data between agent and cnc is stored in database using sql server that running in the same machine in the CNC-Server , every request from agent to DB is done by CNC . </li>
                </ul>

            </div>
        </div>
            <div class="card  bg-dark text-white m-3">
            <div class="card-body">
                <b>Log :</b>
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>every action done by agent is logged in local db inside the agent , and there is copy of the log that stored in remote db (CNC DB)  </li>
                </ul>

            </div>
        </div>
                <div class="card  bg-dark text-white m-3">
            <div class="card-body">
                <b>API :</b>
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i> Support for API calls </li>
                </ul>

            </div>
        </div>
                    <div class="card  bg-dark text-white m-3">
            <div class="card-body">
                <b>Parser :</b>
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>  added support for new IOCs</li>
                </ul>

            </div>
        </div>

    
                    <div class="card  bg-dark text-white m-3">
            <div class="card-body">
                <b>Compiler:</b>
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added support for csvlog reader- to validate what the malware did- revert successful operation, mitigate residue from un-successful actions.</li>
                </ul>

            </div>
        </div>

        <b><span style="font-size:1.5rem">Agent Updates:</span></b>
          <div class="card  bg-dark text-white m-3">
            <div class="card-body">
             
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>Local SQLite server: all log data is saved in a local SQLite server for robustness in case of internet connection loss, CNC can access these logs using an the API.</li>
                     <li class="m-2"><i class="fa-li fa fa-angle-right"></i>CSV file: agent creates and cleans (before every run) a csvlog folder to store the malware’s CSV file (that informs of the malware’s actions) and reads it during the malware’s run to log in the local log (mentioned before)</li>
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>Contact with CNC: contact with CNC changed, the agent will send requests only on 3 occasions: 
<br />When an agent starts up - to add  in CNC’s agent list (or update info and mark as alive if recurring agent)
<br />When an agent receives a malware - to update that the malware is available in the agent
<br />When the agent’s status changes - to update the status in the CNC
</li>
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>Main parameters: there is an option to send 2 parameters to the agent, CNC IP and CNC PORT, these will be used to connect to the CNC, if the parameters are not sent, the user is prompted to enter them using the terminal
</li>
                       <li class="m-2"><i class="fa-li fa fa-angle-right"></i>General bug fixes and code clean up
</li>
                </ul>

            </div>
        </div>

            <b><span style="font-size:1.5rem">IOCs :</span></b>
    <p>All implemented IOCs revision protocols are now aware of the results of the malware emulators, which means it will not affect un-successful operations.
</p>
          <div class="card  bg-dark text-white m-3">
            <div class="card-body">
             <b>File\Registry IO’s </b>
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>Added full support for File\Registry IOCs (Process IOC already implemented) which include Malware Deletion, Creation and Modification. IOCs can now be created and delivered via the pre.exe and post.exe, which interact with the malware through the csvlog.</li>
                </ul>

            </div>
        </div>

  
    
            <b id="problems"><span style="font-size:1.5rem">Problems encountered :</span></b>
    <p>All implemented IOCs revision protocols are now aware of the results of the malware emulators, which means it will not affect un-successful operations.
</p>
      <div class="alert alert-danger" role="alert">
 Coronavirus - COVID -19
</div>
          <div class="card  bg-danger text-white m-3">
            <div class="card-body">
        
                <ul class="fa-ul">
                    <li class="m-2"><i class="fa-li fa fa-angle-right"></i>The requested malware in acceptance test 1- Dyre-RTA had a problem being “frozen” a dependency for some of the actions isn’t freeze aware and behave badly when frozen to exe.</li>
                      <li class="m-2"><i class="fa-li fa fa-angle-right"></i>This means that we could not send malware to a new machine without it having python/additional resources prior to running the malware.
<br />We changed the malware implementation so that it doesn’t use the bad package, but it will be necessary to check the implications of that change.</li>
                      <li class="m-2"><i class="fa-li fa fa-angle-right"></i>Because of the coronavirus, it was problematic to test deployment at the labs, as there are basically no active users.</li>
                </ul>

            </div>
        </div>
</asp:Content>

