<h1>Azure Active Directory User Administration</h1>

<h2>Introduction</h2>

This Project consists of steps on how to:
 <ol type = "1">
  
<li>Set up Azure VMs & Install Active directory</li>
<li>Creating a Domain Admin, and Service accounts</li>
<li>Configure DNS settings & Remote Connection as a Domain Admin</li>
<li>Use PowerShell to generate 1,000 users in AD</li>
</ol>

<h2>Languages and Utilities Used</h2>

- <b>Active Directory</b> 
- <b>Remote Desktop Protocol</b>
- <b>PowerShell</b>
- <b>Microsoft Azure</b>

<h2>Environments Used </h2>

- <b>Windows Server 2022</b> 
- <b>Windows 10</b> 

<h2>Program walk-through:</h2>

<details><summary><h3>Part 1: Setup👷</h3></summary>

First, using Microsoft Azure, create a new virtual machine. This VM will host active directory and be using Windows Server 2022

<img src="https://i.imgur.com/uYfHMQG.png" height="70%" width="70%" alt="9"/><br />

<img src="https://i.imgur.com/FNoA7m0.png" height="70%" width="70%" alt="9"/><br />

Now create the needed admin login credentials for signing into the VM. A .rdp application will download to your PC. Upon opening the .rdp application Your admin credentials will need to be filled out every time to connect to the Azure VM.

After connecting to the RDP server Windows Server 2022 "Server Manager" should open on launch if not, it is a default application built into Windows Server 2022 so you can access it through the search bar in the bottom left, To Install Active Directory go to the Domain Controller. In "Server Manager" click on "Add roles and features."

<img src="https://i.imgur.com/WT17G3x.png" height="80%" width="80%" alt="9"/><br />

Click "Next" until reaching the "Server Roles" section. Now, check the box next to "Active Directory Domain Services" and then "Add Features."

<img src="https://i.imgur.com/K5oTmkD.png" height="80%" width="80%" alt="9"/><br />

Click Next until reaching the "Confirmation" tab then click "Install." It may take a while to install. Once it says "Configuration required. Installation succeeded on (Your DC name here). Click "Close"

A window will pop up for a Configuration Wizard. Check the bubble next to "Add a new forest" then give it a domain (Example in image below) Click next.

<img src="https://i.imgur.com/BefHqfW.png" height="80%" width="80%" alt="9"/><br />

Give it a DSRM password, Click next.

<img src="https://i.imgur.com/TYXfTrJ.png" height="80%" width="80%" alt="9"/><br />

Next, the NETBIOS domain will be made. This may take a moment. Once it is made, Click next until reaching the "Prerequisites Check" tab. This process will take a moment. Now click "Install"

After Installing the VM will reboot. Once it is rebooted, Log back into the Domain Controller with the domain name and the username. 

</details>
<details><summary><h3>Part 2: Creating a Domain Admin :crown: </h3></summary>

Once logged in, using Server Manager click on tools in the top-right corner. Next, click on "Active Directory Users and Computers."

<img src="https://i.imgur.com/grdGvPg.png" height="70%" width="70%" alt="9"/><br />

In the Domain container, create a new "Organizational Unit"

<img src="https://i.imgur.com/9DGmBMS.png" height="80%" width="80%" alt="9"/><br />

Name the OU "_ADMINS", then click OK. In the "_ADMINS" tab, create a new "User"

<img src="https://i.imgur.com/gUev6rr.png" height="80%" width="80%" alt="9"/><br />

Name this anything. Just remember the user and password. Uncheck the box that is next to "User must change password at next logon." This won't be necessary. Click next then click Finish.

<img src="https://i.imgur.com/fmMKhNj.png" height="50%" width="50%" alt="9"/><br />
<img src="https://i.imgur.com/S0c7T05.png" height="50%" width="50%" alt="9"/><br />

Now add this user to the "Domain Admins" security group. Right-click on the user create, then click "Properties." Click on the "Members of" tab, then click "Add." 

<img src="https://i.imgur.com/3MooGCr.png" height="50%" width="50%" alt="9"/><br />

Type "domain" in the box under "Enter the object names to select:" then click "Check Names" 

<img src="https://i.imgur.com/WnHnpsK.png" height="60%" width="60%" alt="9"/><br />

Choose the "Domain Admins" option then click OK

<img src="https://i.imgur.com/eHOKSWT.png" height="80%" width="80%" alt="9"/><br />

Now, click "Apply." The user has successfully been added to the Domain Admins security group. Click OK. Now log out of the Domain controller and re-log as the user just created.

<img src="https://i.imgur.com/oECi1Rd.png" height="50%" width="50%" alt="9"/><br />
</details>
<details><summary><h3>Part 3: Setting Client DNS Settings to Domain Controller Private IP Address :signal_strength: </h3> </summary>

First, on Azure go to the Client VM. Next, go to the Networking tab and click on the Network Interface.

<img src="https://i.imgur.com/0jFQlMM.png" height="60%" width="60%" alt="9"/><br />

Next, go to the "DNS Servers tab and create a custom DNS Server. Add a custom server using the Domain Controller's Private IP address. Example Below.

<img src="https://i.imgur.com/DK1mOBp.png" height="60%" width="60%" alt="9"/><br />

Now click "Save" Next go back to the Client and click "Restart in the "Overview" tab 

<img src="https://i.imgur.com/Cq7d1PZ.png" height="80%" width="80%" alt="9"/><br />

Once the Client is restarted, login to the client with Remote Desktop as the admin account created.

<img src="https://i.imgur.com/LkqUK6Q.png" height="50%" width="50%" alt="9"/><br />

Once logged in go to Settings>System>About and click on "Rename this PC(advanced)"

<img src="https://i.imgur.com/1tu4Kwj.png" height="80%" width="80%" alt="9"/><br />

Now Click on "Change..."

<img src="https://i.imgur.com/zKDbFIs.png" height="50%" width="50%" alt="9"/><br />

Now check the bubble next to "Domain" then type in the domain name (Your domain name). There should be a window that pops up for a login. Use the admin previously created to login. Example below:

<img src="https://i.imgur.com/nT3wd3q.png" height="80%" width="80%" alt="9"/><br />
<img src="https://i.imgur.com/oVmTUG5.png" height="40%" width="40%" alt="9"/><br />

Success. The VM will now restart after a short period.

Now, log into the Domain Controller. Go back to Server Manager>Tools>Active Directory Users and Computers. Under the Domain container, go to the "Computers" tab. It should show that the client has been added to the list.

<img src="https://i.imgur.com/TT1JXxR.png" height="80%" width="80%" alt="9"/><br />

Now, log into the Client as the admin user created and go to System Settings>Remote Desktop. Click on "Select users that can remotely access this PC" Next click Add.

<img src="https://i.imgur.com/oKxoprK.png" height="80%" width="80%" alt="9"/><br />

In the box at the bottom, type in "Domain Users" and Check Names. Next, click OK.

<img src="https://i.imgur.com/JXijlI7.png" height="60%" width="60%" alt="9"/><br />
</details>
<details><summary><h3>Part 4: Creating Domain Users :couple: </h3></summary>

In the Domain Controller, open "Windows PowerShell ISE." Make sure to open it as Administrator. Click "New File" in the top left corner.

<img src="https://i.imgur.com/I3165Lu.png" height="85%" width="85%" alt="9"/><br />
<img src="https://i.imgur.com/Y5BAh4S.png" height="80%" width="80%" alt="9"/><br />

Next, copy and paste the script from this link into the text editor. 

https://github.com/AnthonySarmiento1/AzureActiveDirectory/blob/main/PowerShell%20Scripts/BulkUsersCreator.ps1

Choose "BulkUsersCreator.ps1".

<img src="https://i.imgur.com/GzmEkmQ.png" height="80%" width="80%" alt="9"/><br />

Run "Set-ExecutionPolicy Unrestricted" in the command line.

```command line
Set-ExecutionPolicy Unrestricted
```

<img src="https://i.imgur.com/xCzIjyZ.png" height="65%" width="65%" alt="9"/><br />

Change the directory to "script".

```command line
cd C:\Users\tsmith\Desktop\1_CREATE_USERS.psy
```

Now, click the Run button to run the script. This will start creating domain users with usernames and passwords (The Password for these users will be "AnthonyPass")


<img src="https://i.imgur.com/RMyC0Co.png" height="80%" width="80%" alt="9"/><br />

Go to Server Manager>Tools>Active Directory Users and Computers. Under the "_EMPLOYEES" tab, look at all of the users created from the script.

<img src="https://i.imgur.com/f2xPlao.png" height="80%" width="80%" alt="9"/><br />

These names are all randomly generated. Choose one and log into the Client VM with the username it is assigned. (Remember the password is "AnthonyPass")

<img src="https://i.imgur.com/LoWC3Er.png" height="50%" width="50%" alt="9"/><br />
</details>
