#-----------------------------------------------------
# 22-powerbi-admin-rest-calls.ps1
# atwork.at, Toni Pohl
# Some API calls to run after a successful login
#-----------------------------------------------------

# We are going to focus on the module and cmdlets that deal with reports. 
# Any missing functionality can be overcome with calling the swiss army cmdlet named Invoke-PowerBIRestMethod.
# https://docs.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/invoke-powerbirestmethod?view=powerbi-ps

# Useful 
Invoke-PowerBIRestMethod -Method Get -Url 'admin/reports'

# Explore deeper:
$reports = Invoke-PowerBIRestMethod -Method Get -Url 'admin/reports' | ConvertFrom-Json
$reports.value

# Get the users of a report
$onereport = Invoke-PowerBIRestMethod -Url 'admin/reports/<reportid>/users' -Method Get | ConvertFrom-Json
$onereport.value

# Infos about groups
$groups = Invoke-PowerBIRestMethod -Method Get -Url 'groups' | ConvertFrom-Json | select-object -ExpandProperty value
$groups

# etc.
