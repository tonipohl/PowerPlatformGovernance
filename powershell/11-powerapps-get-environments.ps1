#-----------------------------------------------------
# 11-powerapps-get-environments.ps1
# atwork.at, Toni Pohl
# Sign-in and get Power Apps
#-----------------------------------------------------

# Ask for credentials (Alternatively: Use App authentication flows)
Add-PowerAppsAccount

# Get the environments
Get-AdminPowerAppEnvironment | ft

# Get all or the default environment
# $environment = Get-AdminPowerAppEnvironment -Default
# or get a specific environment
$environment = Get-AdminPowerAppEnvironment -EnvironmentName '<your-environmentid>'
$environment

# $environmentid = $environment.Internal.id
# If needed, we can extract the ID from the property
# "/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments/Default-<your-environmentid>"
$environmentid = $environment.Internal.id.split("/")[-1]
Write-Output "Environment ID: $environmentid"

# End.