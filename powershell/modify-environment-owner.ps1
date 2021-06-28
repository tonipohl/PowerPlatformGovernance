#-----------------------------------------------------
# modify-environment-owner.ps1
#-----------------------------------------------------
# https://o365withlalit.wordpress.com/2020/07/01/change-ownership-of-powerapps/

Get-AdminPowerAppEnvironment | ft

# $environment = Get-AdminPowerAppEnvironment -Default
# or
# a19c40e9-731d-4338-aa9e-c83c502185d8         Dev Environment (org8a8b86ab)            
$environment = Get-AdminPowerAppEnvironment -EnvironmentName 'a19c40e9-731d-4338-aa9e-c83c502185d8'
$environment

# $environmentid = $environment.Internal.id
# We need to extract the ID only from 
# "/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments/Default-<someid>"
$environmentid = $environment.Internal.id.split("/")[-1]
Write-Output "Environment ID: $environmentid"

# Get the apps with one specific owner
# Get-AdminPowerApp -Owner john.doe@consotoso.com -EnvironmentName $environmentid

# Sets permissions to an environment
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powerapps.administration.powershell/set-adminpowerappenvironmentroleassignment?view=pa-ps-latest
# Set-AdminPowerAppEnvironmentRoleAssignment -EnvironmentName $environmentid -RoleName EnvironmentAdmin -PrincipalType User -PrincipalObjectId [Guid]
