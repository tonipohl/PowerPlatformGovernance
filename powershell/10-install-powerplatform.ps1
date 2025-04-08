#-----------------------------------------------------
# 10-install-powerplatform.ps1
# atwork.at, Toni Pohl
# Note: PowerShell in this topic works with the latest PowerShell version 7. 
# To check the version of PowerShell running on your machine, run the following command:
# $PSVersionTable.PSVersion
# See the path of the installed modules with:
# $env:PSModulePath
# Get the installation path of all PowerShell modules
# $env:PSModulePath -split ';'
# Power Platform Admin modules:
# https://docs.microsoft.com/en-us/power-platform/admin/powerapps-powershell
#-----------------------------------------------------
Install-Module -Name Az -Scope CurrentUser # -Repository PSGallery -Force

# https://docs.microsoft.com/en-us/power-platform/admin/powerapps-powershell
# https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-admin?view=pa-ps-latest
# https://powerapps.microsoft.com/en-us/blog/gdpr-admin-powershell-cmdlets/
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell -Scope CurrentUser
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber -Scope CurrentUser
# https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-checker?view=pa-ps-latest
# "This module is for solution developers to perform rich static analysis checks on their solutions against a set of best practice rules to quickly identify problematic patterns."
Install-Module -Name Microsoft.PowerApps.Checker.PowerShell -Scope CurrentUser

# If needed:
# Update-Module -Name Microsoft.PowerApps.Administration.PowerShell -Scope CurrentUser
# Update-Module -Name Microsoft.PowerApps.PowerShell -Scope CurrentUser
# Update-Module -Name Microsoft.PowerApps.Checker.PowerShell -Scope CurrentUser

# Useful for looking up user Id´s and more
# Update-Module -Name Az -Scope CurrentUser

# Check the latest installed version with
Get-InstalledModule -Name Microsoft.PowerApps.Administration.PowerShell, Microsoft.PowerApps.PowerShell

# Current version (April 2025)
# 2.0.209              Microsoft.PowerApps.Administration… PSGallery 
# 1.0.40               Microsoft.PowerApps.PowerShell      PSGallery
