#-----------------------------------------------------
# 13-powerapps-modify-environment-owner.ps1
# atwork.at, Toni Pohl
# Some cmdlets to run after a successful login
# https://o365withlalit.wordpress.com/2020/07/01/change-ownership-of-powerapps/
#-----------------------------------------------------

Get-AdminPowerAppEnvironment | ft

# $environment = Get-AdminPowerAppEnvironment -Default
# or use your environment id
$environment = Get-AdminPowerAppEnvironment -EnvironmentName '<your-environmentid>'
$environment

# $environmentid = $environment.Internal.id
# We need to extract the ID only from 
# "/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments/<your-environmentid>"
$environmentid = $environment.Internal.id.split("/")[-1]
Write-Output "Environment ID: $environmentid"

# Get the apps with one specific owner
# Get-AdminPowerApp -Owner john.doe@consotoso.com -EnvironmentName $environmentid

# Sets permissions to an environment
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powerapps.administration.powershell/set-adminpowerappenvironmentroleassignment?view=pa-ps-latest
# Set-AdminPowerAppEnvironmentRoleAssignment -EnvironmentName $environmentid -RoleName EnvironmentAdmin -PrincipalType User -PrincipalObjectId [Guid]

# End.
