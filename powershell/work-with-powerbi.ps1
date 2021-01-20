#-----------------------------------------------------
# work-with-powerbi.ps1
#-----------------------------------------------------
# https://docs.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps

# Install-Module -Name MicrosoftPowerBIMgmt
# or update
# Update-Module -Name MicrosoftPowerBIMgmt

# Important tip:
# https://github.com/microsoft/powerbi-powershell/issues/60
# I can run using PowerShell 7.1.0,  I have never been able to run in in Powershell 5.

Import-Module -Name MicrosoftPowerBIMgmt

Get-Module MicrosoftPowerBI* -ListAvailable

# https://github.com/microsoft/powerbi-powershell/issues/60
Get-Module MicrosoftPowerBIMgmt* -ListAvailable | Uninstall-Module -Force
Install-Module MicrosoftPowerBIMgmt
Resolve-PowerBIError -Last

# Connect, or use aliases: Login-PowerBIServiceAccount, Login-PowerBI
Connect-PowerBIServiceAccount

# Get all my workspaces (or just the first ones)
Get-PowerBIWorkspace -First 10 | fl
Get-PowerBIWorkspace -All | ft

$workspaceid = "<someid>"

# Get all workspaces as Admin:
Get-PowerBIWorkspace -Scope Organization -All | ft

# Get my dashboards
Get-PowerBIDashboard -WorkspaceId $workspaceid 

# Get the reports
Get-PowerBIReport -WorkspaceId $workspaceid 

# Get all workspaces as Admin:
Get-PowerBIReport -Scope Organization

# Add a new user to a workspace
# Add-PowerBIWorkspaceUser -Scope Organization -Id <someid> -UserEmailAddress john@contoso.com -AccessRight Admin