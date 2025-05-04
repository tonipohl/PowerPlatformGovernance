#-----------------------------------------------------
# 12-powerapps-modify-app-roles.ps1
# atwork.at, Toni Pohl
# Some cmdlets to run after a successful login
#-----------------------------------------------------

$environmentid

# Get all Power Apps
$apps = Get-AdminPowerApp | Where-Object {$_.EnvironmentName -eq $environmentid } 
# $apps | Format-Table -Property DisplayName, CreatedTime, EnvironmentName 
$apps | ft
$apps | export-csv .\apps.csv -Delimiter "," -Encoding UTF8 -NoTypeInformation
$apps.count

# AGet a specific Power App by name
$myapp = $apps | Where {$_.DisplayName -eq "DeviceOrderDemo"  }
$myapp.AppName

# Get the permissions for a specific Power App
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

# End.
