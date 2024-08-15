#-----------------------------------------------------
# 20-install-powerbi.ps1
# atwork.at, Toni Pohl
# Note: PowerShell in this topic requires PowerShell Core 7. 
# To check the version of PowerShell running on your machine, run the following command:
# $PSVersionTable.PSVersion
# See the path of the installed modules with:
# $env:PSModulePath
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
Get-InstalledModule -Name MicrosoftPowerBIMgmt

# Current version (August 2024)
# 1.2.1111             MicrosoftPowerBIMgmt                PSGallery 

# If needed:
# Update-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser

# Check the latest installed version with
Get-Module MicrosoftPowerBI* -ListAvailable

# Notes: If you run into this issue:
# https://github.com/microsoft/powerbi-powershell/issues/60
# I can run using PowerShell 7.1.0, I have never been able to run in in Powershell 5.
# Get-Module MicrosoftPowerBIMgmt* -ListAvailable | Uninstall-Module -Force
# Install-Module MicrosoftPowerBIMgmt -scope CurrentUser
# Resolve-PowerBIError -Last
