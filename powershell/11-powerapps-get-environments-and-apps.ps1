#-----------------------------------------------------
# 11-powerapps-get-environments-and-apps.ps1
# atwork.at, Toni Pohl
#-----------------------------------------------------

# Ask for credentials
Add-PowerAppsAccount

# Alternatively: Here is how you can pass in credentials (avoiding opening a prompt) - works only without MFA!
# $pass = ConvertTo-SecureString "password" -AsPlainText -Force
# Add-PowerAppsAccount -Username foo@bar.com -Password $pass

# Get the environments
Get-AdminPowerAppEnvironment | ft

#$environment = Get-AdminPowerAppEnvironment -Default
# Get "Dev Environment"
$environment = Get-AdminPowerAppEnvironment -EnvironmentName '<your-environmentid>'
$environment

# $environmentid = $environment.Internal.id
# We need to extract the ID only from 
# "/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments/Default-<your-environmentid>"
$environmentid = $environment.Internal.id.split("/")[-1]
Write-Output "Environment ID: $environmentid"

$apps = Get-AdminPowerApp | Where-Object {$_.EnvironmentName -eq $environmentid } 
# $apps | Format-Table -Property DisplayName, CreatedTime, EnvironmentName 
$apps | ft
$apps | export-csv .\apps.csv -Delimiter "," -Encoding UTF8 -NoTypeInformation
$apps.count

# AppName: Device-Order
$myapp = $apps | Where {$_.DisplayName -eq "DeviceOrderDemo"  }
$myapp.AppName

# Get the permissions for a specific app
# Get-AdminPowerAppRoleAssignment (previously Get-AdminAppRoleAssignment)
Get-AdminPowerApp -AppName $myapp.AppName -EnvironmentName $environmentid `
    | Get-AdminPowerAppRoleAssignment  `
    | Select PrincipalDisplayname, PrincipalObjectId, RoleType, AppName, EnvironmentName `
    | ft

# Add a user. We need the UserID from Azure AD.
# $userid = "<userid>"

# or lookup the signed-in user:
# $myuser = Get-AzADUser -SignedIn
# $userid = $myuser.Id

# Add permissions to an app = Share the app. The user gets an email if -Notify $true (default)
Set-AdminPowerAppRoleAssignment -PrincipalType Group -PrincipalObjectId $userid -RoleName CanEdit `
    -AppName $myapp.AppName -EnvironmentName $environmentid -Notify DoNotNotify

# Change owner: Set-AdminPowerAppOwner (previously Set-AdminAppOwner)
Set-AdminPowerAppOwner -AppName $myapp.AppName -AppOwner $userid -EnvironmentName $environmentid

# Remove a user
$removeuserid = "<userid>"
Remove-AdminPowerAppRoleAssignment -RoleId $removeuserid -EnvironmentName $environmentid -AppName $myapp.AppName

# Check it
Get-AdminPowerApp -AppName $myapp.AppName -EnvironmentName $environmentid `
    | Get-AdminPowerAppRoleAssignment  `
    | Select PrincipalDisplayname, PrincipalObjectId, RoleType, AppName, EnvironmentName `
    | ft
