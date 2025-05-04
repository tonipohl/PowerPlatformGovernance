#-----------------------------------------------------
# 21-powerbi-get-data.ps1
# atwork.at, Toni Pohl
# Some cmdlets to run after a successful login
#-----------------------------------------------------

# https://community.powerbi.com/t5/Service/Offline-installation-of-PowerBI-PowerShell-Module/m-p/1238245
Import-Module -Name MicrosoftPowerBIMgmt

# https://docs.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/connect-powerbiserviceaccount?view=powerbi-ps
# Connect (you can use aliases: Login-PowerBIServiceAccount, Login-PowerBI)
Connect-PowerBIServiceAccount

# Get all my workspaces (or just the first ones)
Get-PowerBIWorkspace -First 10 | fl
Get-PowerBIWorkspace -All | ft

$workspaceid = "<your-workspaceid>"

# Get all workspaces as Admin:
Get-PowerBIWorkspace -Scope Organization -All | ft

# Get my dashboards
Get-PowerBIDashboard -WorkspaceId $workspaceid 

# Get the reports
Get-PowerBIReport -WorkspaceId $workspaceid 

# Get all workspaces as Admin:
Get-PowerBIReport -Scope Organization

# Add a new user to a workspace
# Add-PowerBIWorkspaceUser -Scope Organization -Id <your-workspaceid> -UserEmailAddress john@contoso.com -AccessRight Admin

# End.