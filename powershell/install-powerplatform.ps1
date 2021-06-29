#-----------------------------------------------------
# install-powerplatform.ps1
# Note: PowerShell in this topic requires PowerShell version 5.x. 
# To check the version of PowerShell running on your machine, run the following command:
# $PSVersionTable.PSVersion
# https://docs.microsoft.com/en-us/power-platform/admin/powerapps-powershell
#-----------------------------------------------------

# https://docs.microsoft.com/en-us/power-platform/admin/powerapps-powershell
# https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-admin?view=pa-ps-latest
# https://powerapps.microsoft.com/en-us/blog/gdpr-admin-powershell-cmdlets/
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber

# https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-checker?view=pa-ps-latest
# "This module is for solution developers to perform rich static analysis checks on their solutions against a set of best practice rules to quickly identify problematic patterns."
Install-Module -Name Microsoft.PowerApps.Checker.PowerShell

# Check the latest installed version with
Get-InstalledModule -Name Microsoft.PowerApps.Administration.PowerShell, Microsoft.PowerApps.PowerShell

# Current version (June 2021)
# 2.0.126    Microsoft.PowerApps.Administrati... PSGallery
# 1.0.20     Microsoft.PowerApps.PowerShell      PSGallery

