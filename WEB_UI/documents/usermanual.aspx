<%@ Page Title="" Language="C#" MasterPageFile="~/documents/MasterPage.master" AutoEventWireup="true" CodeFile="usermanual.aspx.cs" Inherits="documents_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<title>User manual
	</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

	<h1><i class="fa fa-chevron-right p-1 "></i>ReWare User Manual</h1>
	<hr />
	<p>
		In this manual, we will cover the different parts that form ReWare and how to use them effectively to emulate malwares, monitor their activity, and revert their side effects.
		<br />
		ReWare is made from 3 parts: A Web-GUI, The CNC Server, and numerous Agent application running on user's machines.
	</p>
	<b>Glossary:</b>
	<ul class="fa-ul">
		<li class="m-3"><i class="fa-li fa fa-square"></i>Registry- windows global variables,used in almost all of windows applications.</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>File- The file system, including directories.</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>Process- Processes of windows system</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>Network- DNS requests, open ports.</li>

	</ul>
	<b>Web-GUI:</b>
	<p>
		To access the GUI the user should navigate the following address on a computer connected to BGU lab's internet: 132.72.81.38
		<br />
		The Web-GUI is the main portal for interacting with ReWare, it allows performing changes and running malware emulators on the agents. Using the GUI, it is also possible to retrieve valuable information regarding the Agents' status and the history of the malwares' actions within them.
	</p>
	<ul class="fa-ul">
		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>Log-in Screen</b>
			<ul class="fa-ul">
				<li class="m-3">
					<img src="imgs2/image002.jpg" class="m-1" style="max-width: 100%" />
					<p>
						When navigating to the Web-GUI, the first thing the user will encounter is the log-in screen. All users must be registered and will be required to log-in before accessing the rest of the application.
						<br />
						<b>The default user is:
							<br />
							Username: Admin 
							<br />
							Password: 123456</b>
					</p>
				</li>
			</ul>
		</li>

		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>Home Screen</b>
			<ul class="fa-ul">
				<li class="m-3">
					<p>After logging in the user will be transferred to the Home screen.</p>
					<img src="imgs2/image004.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>
						The home page contains the menu on the left with all available sections: Malwares, Agents, Settings. Also displayed, is the user's information on the top right.
						<br />
						To perform any action, the user should select the appropriate section from the menu on the left.
					</p>
				</li>
			</ul>
		</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>Malwares Screen</b>
			<ul class="fa-ul">
				<li class="m-3">
					<p></p>
					<img src="imgs2/image006.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>
						When navigating to the Malwares screen, the user will be greeted with a page containing information regarding all malwares currently available on the CNC. 
						<br />
						This page contains the following information regarding each malware:<br />

					</p>
					<p class="ml-3">
						1.	# (ID) – the malware's ID, used as an identification<br />
						2.	Title – the malware's name<br />
						3.	Description – a short description describing the malwares effects and actions<br />
						4.	Publisher – a name of the malware uploader<br />
						5.	Date – the date in which the malware was uploaded<br />
						6.	Status – the malware's status, options: UPLOADED – the CNC received the malware, but some parsing is still to be done, READY – parsing is complete, the malware is ready to be sent<br />
					</p>

					<p>
						Each malware also has an Edit button which can be used to edit a malware's information.
						<br />
						The page contains an Add button, used to add new malwares to the system. Clicking this button, the user is transferred to a page asking to fill in the required information:
					</p>
					<img src="imgs2/image008.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>
						The user should upload 3 files for each malware:
					</p>
					<p class="ml-3">
						1.	A .exe file – the malware emulator itself, which will be sent to the agent.<br />
						2.	A .csv file – a table containing information regarding the actions the malware will make, this will be used to revert these actions.<br />
						3.	A .json file – a json file describing the malware<br />
					</p>
					<p>Clicking save will upload the malware to the CNC server, the CNC will then start parsing the malware – preparing it for use.</p>
				</li>
			</ul>
		</li>


		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>Agents Screen</b>
			<ul class="fa-ul">
				<li class="m-3">
					<img src="imgs2/image010.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>
						When navigating to the Agents screen, the user will be greeted with a page containing information regarding all agents which interacted with the CNC.
						<br />
						This page contains the following information regarding each agent:
					</p>

					<p class="ml-3">
						1.	Host Name – the agent's machine name<br />
						2.	IP Address – the agent's machine IP address<br />
						3.	Port – the port on which the agent application is ran<br />
						4.	Status – the agent's status, options: Cloud – the agent is online and "alive", Cross – the agent is inactive and "dead"<br />
						5.	Last update – the last time a connection with the agent was made<br />

					</p>
					<p>
						The page contains a refresh button, clicking this button pings all agents in the table for a response, updating the status accordingly.

						<br />
						Each agent also has a button for further action. When clicked, this button leads to the agent's page:
					</p>
					<img src="imgs2/image012.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>
						This page displays all the information available in the agents' table while having another table displaying all malwares available on this agent.
						<br />
						<br />
						Malwares uploaded to the CNC and parsed can be sent to the agent by inserting the malware ID in the field called 'Add new malware' and hitting Send.
						<br />
						<br />
						The agent's malware table contains the following information regarding each malware:

					</p>
					<p class="ml-3">
						1.	# (ID) – the malware's ID, used as an identification<br />
						2.	Malware – the malware's name<br />
						3.	Date – the date in which the malware was uploaded<br />
						4.	Last update – the last time in which this malware was updated<br />
					</p>
					<p>
						Each malware also has a button: 'Run', which is used to run the malware on the agent.<br />
						After running the malware this button will change to 'Revert' which is used to revert the malware's actions.
					</p>
					<img src="imgs2/image014.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>The agent page also contains a state machine button:</p>
					<img src="imgs2/image015.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>Clicking this button will lead to the agent's system log screen.</p>
				</li>
			</ul>
		</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>System Log Screen</b>
			<ul class="fa-ul">
				<li class="m-3">

					<img src="imgs2/image017.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>
						<br />
						When navigating to the System Log screen, the user will be greeted with a page containing information a certain agent logged about it's and its' malwares activity.  This page should be used to monitor the agent's action and the actions of the malwares executed.
						<br />
						Each log entry contains the following information:

					</p>
					<p class="ml-3">
						1.	Timestamp – the time this entry was made<br />
						2.	Agent's status – the agent's status at the time of the entry, options: WAITING – the agent is ready for commands, RUNNING – a malware is running on the agent, REVERTING – the agent is reverting a malware's actions.<br />
						3.	Info – Free text information regarding the log entry<br />
					</p>
				</li>
			</ul>
		</li>
		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>Settings Screen</b>
			<ul class="fa-ul">
				<li class="m-3">
					<img src="imgs2/image019.jpg" class="m-1" style="max-width: 100%" /><br />
					<p>
						<br />
						When navigating to the Settings screen, the user will be greeted with a page containing information regarding all users registered to the system.
						<br />
						There is an Edit button near each user, allowing to edit a user's data.<br />
						The Add button on the top right leads to a page allowing to add new users, to add a new user the user should fill out the required information and click Save:<br />
					</p>
					<img src="imgs2/image021.jpg" class="m-1" style="max-width: 100%" /><br />
					<br />
					<p>The Log activity button leads to a page displaying all connection activity of there users, this page includes: User's IP address, Username, Name, and a timestamp:</p>
					<img src="imgs2/image023.jpg" class="m-1" style="max-width: 100%" /><br />
					<br />
				</li>
			</ul>
		</li>

		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>Agent</b>
			<ul class="fa-ul">
				<li class="m-3">
					<p>The agent is the application running on the users' machines. This application is responsible for receiving malwares, executing them, and reverting their side effects, while logging and documenting every step and its' result.</p>
				</li>
				<li class="m-3"><i class="fa-li fa fa-square"></i>
					<b>Running the agent</b>
					<ul class="fa-ul">
						<li class="m-3">
							<p>
								To activate the agent, the user will locate the agent folder, confirm there is a file named 'agent_main.py' and run python using a CMD command as follows:
								<br />
								<br />
								'python agent_main.py'
								<br />
								<br />
								The user will be prompted to enter the CNC's IP address and port for communication. After entering these values, if they are correct and the CNC is online, the agent is running and ready.
							</p>
						</li>
					</ul>
				</li>
			</ul>
		</li>


		<li class="m-3"><i class="fa-li fa fa-square"></i>
			<b>CNC Server</b>
			<ul class="fa-ul">
				<li class="m-3">
					<p>The CNC server is the command and control application orchestrating the distribution and execution of the malwares. This application is responsible for storing and sending the malwares to the agents, communicating with the agents to execute, and revert malwares while retrieving information regarding their work.</p>
				</li>
				<li class="m-3"><i class="fa-li fa fa-square"></i>
					<b>Running the CNC server</b>
					<ul class="fa-ul">
						<li class="m-3">
							<p>
								To activate the CNC server, the user will locate the CNC folder, confirm there is a file named 'cnc_main.py' and run python using a CMD command as follows:<br />
								<br />
								'python cnc_main.py'<br />
								<br />
								The CNC server will load up with the local IP on the port 5000 and will be running and ready.
							</p>
						</li>
					</ul>
				</li>
			</ul>
		</li>


		<li id="faq" class="m-3"><i class="fa-li fa fa-square"></i>
			<b >FAQ</b>
			<ul class="fa-ul">
				<li class="m-3">
					<p><b>How do I log into the system?</b></p>
					<p class="ml-3">The default user's details are – username: Admin, password: 123456. You should use this as a first login and then register more users. (see 'How do I register a new user?' under FAQ)</p>
				</li>
				<li class="m-3">
					<p><b>How do I start up the agent?</b></p>
					<p class="ml-3">Please refer to the 'Running the agent' section in this manual.</p>
				</li>
				<li class="m-3">
					<p><b>How do I start up the CNC Server?</b></p>
					<p class="ml-3">Please refer to the 'Running the CNC server' section in this manual.</p>
				</li>

				<li class="m-3">
					<p><b>How do I upload a malware?</b></p>
					<p class="ml-3">To upload a malware, first make sure you have the necessary files (.exe, .csv, .json – more info in the 'malwares, add new malware' section) Then navigate to the Web-GUI and log-in, select the malwares section, click Add, fill in the information and click Save. More information in the malwares section under Web-GUI</p>
				</li>
				<li class="m-3">
					<p><b>Where do I see which malwares does the CNC have?</b></p>
					<p class="ml-3">To view the available malwares in the system you should navigate to the Web-GUI and log-in, select the malwares section, there you will have a table detailing the available malwares. More information in the malwares section under Web-GUI</p>
				</li>
				<li class="m-3">
					<p><b>How do I send a malware to an agent?</b></p>
					<p class="ml-3">To send a malware to an agent, first make sure the malware was uploaded successfully to the system by navigating to the malwares section – make sure to note his ID (see 'How do I upload a malware?' under FAQ) Then navigate to the Web-GUI and log-in, select the agents section, locate the desired agent and make sure he is online, click on the more actions button, fill in the desired malware ID under 'Add new malware' and hit 'Send'</p>
				</li>
				<li class="m-3">
					<p><b>Where do I see which malwares does the agent have?</b></p>
					<p class="ml-3">To view the available malwares on an agent, you should navigate to the Web-GUI and log-in, select the agents section, locate the desired agent and make sure he is online, click on the more actions button, there you will have a table detailing the available malwares.</p>
				</li>
				<li class="m-3">
					<p><b>How do I run a malware on an agent?</b></p>
					<p class="ml-3">To run a malware on an agent, first make sure the agent has the malware (See 'How do I send a malware to an agent?' under FAQ) Then navigate to the Web-GUI and log-in, select the agents section, locate the desired agent and make sure he is online, click on the more actions button, in the malwares table located the desired malware and hit 'Run'</p>
				</li>
				<li class="m-3">
					<p><b>How do I revert a malware's actions on an agent?</b></p>
					<p class="ml-3">To revert a malware's action on an agent, first make sure the malware ran on the agent (See ' How do I run a malware on an agent?' under FAQ) Then navigate to the Web-GUI and log-in, select the agents section, locate the desired agent and make sure he is online, click on the more actions button, in the malwares table located the desired malware and hit 'Revert'</p>
				</li>
				<li class="m-3">
					<p><b>Where can I see what happened in the agent's machine?</b></p>
					<p class="ml-3">To view an agent's system log you should navigate to the Web-GUI and log-in, select the agents section, locate the desired agent and make sure he is online, click on the more actions button, click the 'state machine' button.</p>
				</li>
				<li class="m-3">
					<p><b>How do I register a new user?</b></p>
					<p class="ml-3">To register a new user to the system you should navigate to the Web-GUI and log-in, select the settings section, click the Add button, fill in the information and click Save.</p>
				</li>
			</ul>
		</li>

	</ul>

</asp:Content>

