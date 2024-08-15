#-----------------------------------------------------
# 20-install-powerbi.ps1
# atwork.at, Toni Pohl
# Note: PowerShell in this topic requires PowerShell Core 7.x. 
# To check the version of PowerShell running on your machine, run the following command:
# $PSVersionTable.PSVersion
#-----------------------------------------------------

# https://docs.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps
# -Scope CurrentUser
Install-Module -Name MicrosoftPowerBIMgmt 

<#
MicrosoftPowerBIMgmt.Admin
MicrosoftPowerBIMgmt.Capacities
MicrosoftPowerBIMgmt.Data
MicrosoftPowerBIMgmt.Profile
MicrosoftPowerBIMgmt.Reports
MicrosoftPowerBIMgmt.Workspaces
#>

# Check the latest installed version with
Get-Module MicrosoftPowerBI* -ListAvailable

# $env:PSModulePath

# Current version (June 2021)
# 1.2.0      MicrosoftPowerBIMgmt                PSGallery

# Notes: If you run into this issue:
# https://github.com/microsoft/powerbi-powershell/issues/60
# I can run using PowerShell 7.1.0, I have never been able to run in in Powershell 5.
# Get-Module MicrosoftPowerBIMgmt* -ListAvailable | Uninstall-Module -Force
# Install-Module MicrosoftPowerBIMgmt -scope CurrentUser
# Resolve-PowerBIError -Last
