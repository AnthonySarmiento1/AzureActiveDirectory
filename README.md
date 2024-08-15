<h1>Azure Active Directory User Administration</h1>

<h2>Introduction</h2>

This Project consists of steps on how to:
 <ol type = "1">
  
<li>Set up Azure VMs & Install Active directory</li>
<li>Created Organizational Units, Groups, and users</li>
<li>Preformed password resets, modified user account data, onboarding/offboarding Users</li>
<li>Used PowerShell to generate 1,000 users in AD</li>
</ol>

<h2>Languages and Utilities Used</h2>

- <b>Active Directory</b> 
- <b>PowerShell</b>
- <b>Server Manager</b>
- <b>Microsoft Azure</b>
- <b>Remote Desktop Protocol</b>
<h2>Environments Used </h2>

- <b>Windows Server 2022</b> 

<h2>Program walk-through:</h2>

<details><summary><h3>Part 1: Setup👷</h3></summary>

First, using Microsoft Azure, create a new virtual machine. This VM will host active directory and be using Windows Server 2022

<img src="https://i.imgur.com/cHuNbev.png" height="70%" width="70%" alt="9"/><br />

<img src="https://i.imgur.com/db22gUT.png" height="70%" width="70%" alt="9"/><br />

<img src="https://i.imgur.com/3ARVoGy.png" height="70%" width="70%" alt="9"/><br />

Now create the needed admin login credentials for signing into the VM. A .rdp application will download to your PC. Upon opening the .rdp application Your admin credentials will need to be filled out every time to connect to the Azure VM.

After connecting to the RDP server Windows Server 2022 "Server Manager" should open on launch if not, it is a default application built into Windows Server 2022 so you can access it through the search bar in the bottom left, To Install Active Directory go to the Domain Controller. In "Server Manager" click on "Add roles and features."

<img src="https://i.imgur.com/WT17G3x.png" height="80%" width="80%" alt="9"/><br />

Click "Next" until reaching the "Server Roles" section. Now, check the box next to "Active Directory Domain Services" and then "Add Features."

<img src="https://i.imgur.com/K5oTmkD.png" height="80%" width="80%" alt="9"/><br />

Click Next until reaching the "Confirmation" tab then click "Install." It may take a while to install. Once it says "Configuration required. Click "Close"

A window will pop up for a Configuration Wizard. Check the bubble next to "Add a new forest" then give it a domain (Example in the image below) Click next.

<img src="https://i.imgur.com/BefHqfW.png" height="80%" width="80%" alt="9"/><br />

Give it a DSRM password, Click next.

<img src="https://i.imgur.com/TYXfTrJ.png" height="80%" width="80%" alt="9"/><br />

Next, the NETBIOS domain will be made. This may take a moment. Once it is made, Click next until the "Prerequisites Check" tab is reached. This process will take a moment. Now click "Install" After Installing the VM will reboot.

Once logged in, using Server Manager click on tools in the top-right corner. Next, click on "Active Directory Users and Computers."

<img src="https://i.imgur.com/grdGvPg.png" height="70%" width="70%" alt="9"/><br />


</details>
<details><summary><h3>Part 2: Creating Organizational Units and Groups 🌁 </h3></summary>

After installing AD, new organizational units (OU's) can be made by right-clicking on [Domain. name] > "New" > "Organizational Unit". The OU is like a container that can sort between different Users, Groups, Computers, Servers, Subnets, etc
<img src="https://i.imgur.com/QXOcCCi.png" height="70%" width="70%" alt="9"/><br />
After I made 3 OU's USA-East, USA-West, and EU to represent different office locations. Then 3 sub OU's (Computers, users, servers) to separate and organize different assets in the company.

<img src="https://i.imgur.com/LjYgbAo.png" height="70%" width="70%" alt="9"/><br />

Next, within USA-West In the "Users" OU I created a new user group to represent an IT department. along with a new user and set the username and password for that new user.

<img src="https://i.imgur.com/QmbgySs.png" height="70%" width="70%" alt="9"/><br />







</details>
<details><summary><h3>Part 3: Managing Users 🔅 </h3> </summary>
 
<li>I was able to reset a user's password by right-clicking on the user and clicking "reset password" which allows us to set a new password.This would be useful if a user may have forgotten their password or must change it due to security concerns.</li>

<img src="https://i.imgur.com/hLmNLIX.png" height="70%" width="70%" alt="9"/><br />

<li>It is also possible to unlock an account if a user knows their password but has been locked out for security reasons. This is possible by double clicking on the user that will open their properties then go to "Account" and "Unlock account" will disable the lockout of that account for a short duration.</li>

<img src="https://i.imgur.com/KpTUESr.png" height="70%" width="70%" alt="9"/><br />

<li>In the "general" tab, within the user properties window user's descriptions can be changed if they moved onto another role within the company, or their office location has been moved. There is also a telephone number, email, or webpage that could be updated.</li>

<img src="https://i.imgur.com/DQYD721.png" height="70%" width="70%" alt="9"/><br />


<li></li>


<li></li>




</details>
<details><summary><h3>Part 4: Creating 1,000 Domain Users with Powershell :couple: </h3></summary>

In the Domain Controller, open "Windows PowerShell ISE." Make sure to open it as Administrator. Click "New File" in the top left corner.

<img src="https://i.imgur.com/I3165Lu.png" height="85%" width="85%" alt="9"/><br />
<img src="https://i.imgur.com/Y5BAh4S.png" height="80%" width="80%" alt="9"/><br />

Next, copy and paste the script from this link into the text editor. 

https://github.com/AnthonySarmiento1/AzureActiveDirectory/blob/main/PowerShell%20Scripts/BulkUsersCreator.ps1

Choose "BulkUsersCreator.ps1". This Script will create a username that is the first letter of a user's first name and then the last name along with a default password that can be changed later.

<img src="https://i.imgur.com/GzmEkmQ.png" height="80%" width="80%" alt="9"/><br />

Run "Set-ExecutionPolicy Unrestricted" in the command line.

```command line
Set-ExecutionPolicy Unrestricted
```

<img src="https://i.imgur.com/xCzIjyZ.png" height="65%" width="65%" alt="9"/><br />

Change the directory to "script".

```command line
cd C:\Users\[Username]\Desktop\BulkUsersCreator.ps1
```

Now, click the "Run" button to run the script. This will start creating domain users with usernames and passwords (The Password for these users will be "AnthonyPass")


<img src="https://i.imgur.com/RMyC0Co.png" height="80%" width="80%" alt="9"/><br />

<img src="https://i.imgur.com/dnmirvw.png" height="80%" width="80%" alt="9"/><br />





</details>


