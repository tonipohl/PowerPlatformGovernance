# PowerShell Helpers for M365 Governance

The PowerShell scripts in this topic works with the latest PowerShell version 7.x  
The scripts are grouped by number blocks for the various topics.  

## Run SetExecutionPolicy to bypass scripts without cert

Changing the PowerShell Script Execution Policy: The Set-ExecutionPolicy cmdlet enables you to determine which PowerShell scripts (if any) will be allowed to run on your computer. PowerShell has four different execution policies:

- Restricted - No scripts can be run. PowerShell can be used only in interactive mode.
- AllSigned - Only scripts signed by a trusted publisher can be run.
- RemoteSigned - Downloaded scripts must be signed by a trusted publisher before they can be run.
- Unrestricted - No restrictions; all PowerShell scripts can be run.

Check your current Excution Policy.

~~~~powershell
Get-ExecutionPolicy  
~~~~

Make sure you comply with yur organization´s policies.  
**Run as Admin!**

~~~~powershell
Set-ExecutionPolicy Unrestricted 
~~~~

E.g. to use chocolatey package manager, run:

~~~~powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
~~~~

Set-ExecutionPolicy -executionpolicy unrestricted

## Check the current version of PowerShell on your machine

~~~~powershell
$PSVersionTable.PSVersion
~~~~

## See the path of the installed modules

~~~~powershell
$env:PSModulePath -split ';'
~~~~

## PowerShell modules

Ensure you have the latest PowerShell Core (v7.x) and the latest modules installed.  
Install the required PowerShell modules first, usually from the PSGallery.  
Best, install the module for your current user, as here:  

~~~~powershell
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell -Scope CurrentUser
~~~~

If needed, update your modules.

~~~~powershell
Update-Module -Name Microsoft.PowerApps.Administration.PowerShell
~~~~

Tip: In case of version conflicts, it is often a good idea to remove the existing PowerShell module by simply deleting the module from the file system, and then reinstall it new. Usually, the PowerShell core module path is in the user´s documents directory, similar as here (use *$env:PSModulePath* as described above to get your path):

~~~~
C:\Users\<username>\OneDrive - <your-organization>\Dokuments\PowerShell\Modules\<modulename>
~~~~

## Check the latest installed module version

~~~~powershell
Get-InstalledModule -Name Microsoft.PowerApps.Administration.PowerShell, Microsoft.PowerApps.PowerShell
~~~~

Check out these requirements to be able to run the scripts from this repository.


