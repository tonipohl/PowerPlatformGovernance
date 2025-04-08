#-----------------------------------------------------
# 14-powerapps-remove-managed-environment.ps1
# atwork.at, Toni Pohl
#-----------------------------------------------------
# Disable a Managed Environment using PowerShell step-by-step (mostly used because of license requirements).
# Admins can use PowerShell to remove the Managed Environments property on an environment. The environment must not be using any Managed Environments capabilities.
# https://learn.microsoft.com/en-us/power-platform/admin/managed-environment-enable#disable-managed-environments-using-powershell
Import-Module -Name Microsoft.PowerApps.Administration.PowerShell

# Ask for credentials
Add-PowerAppsAccount

# List the environments
Get-AdminPowerAppEnvironment | ft

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powerapps.administration.powershell/get-adminpowerappenvironment?view=pa-ps-latest
$allenv = Get-AdminPowerAppEnvironment
$allenv | ft

# Find the Id of the environment...
$environment = Get-AdminPowerAppEnvironment -EnvironmentName '<your-environmentname>'
$environmentid = $environment.EnvironmentName
$environmentid

# Check it
Get-AdminPowerAppEnvironment -EnvironmentName $environmentid

# Enable Managed Environment
# https://learn.microsoft.com/en-us/power-platform/admin/managed-environment-enable

# Disable Managed Environment
# https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-pscustomobject?view=powershell-7.3
$UpdatedGovernanceConfiguration = [pscustomobject]@{
    protectionLevel = "Basic"
}
$UpdatedGovernanceConfiguration

# Remove managed environment property
Set-AdminPowerAppEnvironmentGovernanceConfiguration `
    -EnvironmentName $environmentid `
    -UpdatedGovernanceConfiguration $UpdatedGovernanceConfiguration

# Alternatively: Delete an environment completely
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powerapps.administration.powershell/remove-adminpowerappenvironment?view=pa-ps-latest
# $environment = Get-AdminPowerAppEnvironment -EnvironmentName '<YOUR-ENVIRONEMNT>'
# $environmentid = $environment.EnvironmentName
# $environmentid 
# Remove-AdminPowerAppEnvironment -EnvironmentName $environmentid

# End.
