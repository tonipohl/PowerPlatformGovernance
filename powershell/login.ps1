#-------------------------------------------------------------
# login.ps1
# Note: PowerShell in this topic requires PowerShell version 5.x. 
# To check the version of PowerShell running on your machine, run the following command:
# $PSVersionTable.PSVersion
# https://docs.microsoft.com/en-us/power-platform/admin/powerapps-powershell
#-------------------------------------------------------------
# Ask for credentials
Add-PowerAppsAccount

# Alternatively: Here is how you can pass in credentials (avoiding opening a prompt) - works only without MFA!
# $pass = ConvertTo-SecureString "password" -AsPlainText -Force
# Add-PowerAppsAccount -Username foo@bar.com -Password $pass

