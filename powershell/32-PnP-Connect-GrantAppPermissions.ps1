#---------------------------------------
# 32-PnP-Connect-GrantAppPermissions.ps1
# atwork.at, Toni Pohl
#---------------------------------------
# Connect to a specific SPO site, and add permissions for the app to the site
Import-Module PnP.PowerShell

# Connect
$tenantId = "<your-tenant>.onmicrosoft.com" 
$appId = "<your-appid>"
$appname = "PnP-NewAuth-App"
$url = "https://<your-tenant>.sharepoint.com/sites/<your-site>"

# $consent = "https://login.microsoftonline.com/$TenantName/adminconsent?client_id=$appId"
# $consent

# Get the certificate thumbprint from my local machine : CurrentUser\My\Personal\Certificates 
# This searches all certificates in the Current User > Personal certificate store, filtering by whether the Subject contains the value of $appId.
$cert = Get-ChildItem Cert:\CurrentUser\My | Where-Object {$_.Subject -like "*$($appname)*"}
$cert | Format-List -Property Subject, Thumbprint, NotAfter, FriendlyName, KeySpec, KeyLength, SignatureAlgorithm, PublicKey, PrivateKey

# Connect to SharePoint Online
# https://kunjsangani.com/powershell/cmdlets/Connect-PnPOnline.html#example-7
# https://github.com/pnp/PnP-PowerShell/tree/master/Samples/SharePoint.ConnectUsingAppPermissions
$ConnectInfo = @{
    Tenant = $tenantId
    ClientId = $appId
    Thumbprint = $cert.Thumbprint
    Url = $url
    Interactive = $false
}

# Connect tp the site
Connect-PnPOnline @ConnectInfo 

# If needed, chekc the token used to connect to the site
Get-PnPAccessToken

# If needed, check the connection to the site
Get-PnPConnection

# Try to read the web and the site
Get-PnPWeb
Get-PnPSite

# Search for permission cmdlets
Get-Command Grant-pnp*    

# Get the permissions of the app on the site
Get-PnPAzureADAppSitePermission -Site $url

# If not set, grant the Azure AD App access to the site
Grant-PnPAzureADAppSitePermission `
    -AppId $appId `
    -DisplayName $appname `
    -Site $url `
    -Permissions "FullControl"  # or "Write", "FullControl"

# Check the permissions of the app on the site
Get-PnPAzureADAppSitePermission -Site $url

# 
Get-PnPList

# Get the users of the site
$users = Get-PnPUser
$users

# End.
