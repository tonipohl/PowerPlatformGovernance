#-------------------------------------------
# 23-powerbi-authenticate-with-SPN.ps1
# atwork.at, Toni Pohl
# Get an authentication token as app for Power BI REST API
#-------------------------------------------

<#
Function:
- Use an App (Service Principal) to authenticate against the Power BI REST API.
- Get data from the Power BI REST API and the "/admin" endpoint (only).

Tasks:
- Follow the steps at https://learn.microsoft.com/en-us/fabric/admin/metadata-scanning-enable-read-only-apis
    - Register an Entra ID application in the Azure portal.
    - Do NOT add any permissions to the app: "Make sure the app you use doesn't have any admin-consent required permissions for Power BI set on it in the Azure portal"
    - Get the app's client ID and client secret.
    - Create a new security group (no roles required).
    - Add the app to the security group.
- As Power BI Admin, open https://app.powerbi.com/admin-portal/tenantSettings?experience=power-bi
- Navigate to "Admin API settings" (search for "admin"), and enable the "Service principals can access read-only admin APIs" setting.
- Add the security group to the "Security groups that can use the Power BI admin API" list.
- Wait for up to 15 minutes
- Adapt and run this code: The SPN has READ access to the /admin enpoint only! "Web apps registered in Microsoft Entra ID can use service principals, rather than user credentials, to authenticate to read-only admin APIs."
#>

#-------------------------------------------
# Your Entra ID app
#-------------------------------------------
$tenantId = "<your-tenant-id>"
# PowerBIApp (with NO permissions, but member of the PowerBISecurityGroup)
$clientId = "<your-app-id>"
$clientSecret ="<your-secret>"

$scope = "https://analysis.windows.net/powerbi/api/.default"
$authority = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

#-------------------------------------------
# Get the access token
#-------------------------------------------
$body = @{
    client_id     = $clientId
    scope         = $scope
    client_secret = $clientSecret
    grant_type    = "client_credentials"
}

$response = Invoke-RestMethod -Method Post -Uri $authority -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $response.access_token
$accessToken

# Use the access token to call the Power BI REST API
$headers = @{
    Authorization = "Bearer $accessToken"
}

# Continue getting data with the access token $headers
