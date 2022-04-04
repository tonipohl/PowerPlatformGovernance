#-----------------------------------------------------
# modify-app-roles.ps1
# Some cmdlets to run after a successful login
#-----------------------------------------------------
Get-AdminPowerAppEnvironment | ft

# $environment = Get-AdminPowerAppEnvironment -Default
# or
$environment = Get-AdminPowerAppEnvironment -EnvironmentName 'a123...'

# $environmentid = $environment.Internal.id
# If you need to extract the ID only from "/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments/Default-<someid>"
$environmentid = $environment.Internal.id.split("/")[-1]
Write-Output "Environment ID: $environmentid"

# Get the apps
$apps = Get-AdminPowerApp | Where-Object {$_.EnvironmentName -eq $environmentid } 
$apps | Format-Table -Property DisplayName, CreatedTime, EnvironmentName 
$apps.count

# AppName 
$myapp = $apps | Where {$_.DisplayName -eq "DemoApp1"  }
$myapp.AppName

# Get the permissions for a specific app
# Get-AdminPowerAppRoleAssignment (previously Get-AdminAppRoleAssignment)
Get-AdminPowerApp -AppName $myapp.AppName -EnvironmentName $environmentid `
    | Get-AdminPowerAppRoleAssignment  `
    | Select PrincipalDisplayname, PrincipalObjectId, RoleType, AppName, EnvironmentName `
    | ft

# Add a user. We need the UserID from Azure AD.
$userid = "123456..."

# Add permissions to an app = Share the app. The user gets an email if -Notify $true (default)
Set-AdminPowerAppRoleAssignment -PrincipalType Group -PrincipalObjectId $userid -RoleName CanEdit `
    -AppName $myapp.AppName -EnvironmentName $environmentid -Notify DoNotNotify

# Change owner: Set-AdminPowerAppOwner (previously Set-AdminAppOwner)
Set-AdminPowerAppOwner -AppName $myapp.AppName -AppOwner $userid -EnvironmentName $environmentid

# Remove a user
$removeuserid = "6789..."
Remove-AdminPowerAppRoleAssignment -RoleId $removeuserid -EnvironmentName $environmentid -AppName $myapp.AppName

# Check it
Get-AdminPowerApp -AppName $myapp.AppName -EnvironmentName $environmentid `
    | Get-AdminPowerAppRoleAssignment  `
    | Select PrincipalDisplayname, PrincipalObjectId, RoleType, AppName, EnvironmentName `
    | ft
