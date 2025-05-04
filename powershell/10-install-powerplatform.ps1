#-----------------------------------------------------
# 10-install-powerplatform.ps1
# atwork.at, Toni Pohl
# Note: PowerShell in this topic works with the latest PowerShell version 7. See ReadMe.md.
#-----------------------------------------------------

# Azure module. Useful for looking up user Id´s and more
Install-Module -Name Az -Scope CurrentUser # -Repository PSGallery -Force

# https://docs.microsoft.com/en-us/power-platform/admin/powerapps-powershell
# https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-admin?view=pa-ps-latest
# https://powerapps.microsoft.com/en-us/blog/gdpr-admin-powershell-cmdlets/
# See more at https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-checker?view=pa-ps-latest
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell -Scope CurrentUser
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber -Scope CurrentUser
# https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-checker?view=pa-ps-latest
# This module is for solution developers to perform rich static analysis checks on their solutions against a set of best practice rules to quickly identify problematic patterns.
Install-Module -Name Microsoft.PowerApps.Checker.PowerShell -Scope CurrentUser

# If needed:
# Update-Module -Name Microsoft.PowerApps.Administration.PowerShell -Scope CurrentUser
# Update-Module -Name Microsoft.PowerApps.PowerShell -Scope CurrentUser
# Update-Module -Name Microsoft.PowerApps.Checker.PowerShell -Scope CurrentUser
# Update-Module -Name Az -Scope CurrentUser

# Check the latest installed version with
Get-InstalledModule -Name Microsoft.PowerApps.Administration.PowerShell, Microsoft.PowerApps.PowerShell

