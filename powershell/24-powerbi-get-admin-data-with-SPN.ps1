#-------------------------------------------
# 24-powerbi-get-admin-data-with-SPN.ps1
# atwork.at, Toni Pohl
#-------------------------------------------
# Get data from the /admin endpoint with the app token from the previous script.


# Get workspaces as admin
# https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-get-groups-as-admin#uri-parameters
# - $top: Returns only the first n results. This parameter is mandatory and must be in the range of 1-5000.
# - $skip: Skips the first n results. Use with top to fetch results beyond the first 5000.
# - Maximum 50 requests per hour or 15 requests per minute, per tenant. This call will also time out after 30 seconds to prevent adverse effect on the Power BI service.
# !! Use %24 instead of $ !!
$apiUrl = "https://api.powerbi.com/v1.0/myorg/admin/groups?%24top=10&%24skip=0"
$response = Invoke-RestMethod -Method Get -Uri $apiUrl -Headers $headers

$response.value | ft


# Get reports as admin
# https://learn.microsoft.com/en-us/rest/api/power-bi/admin/reports-get-reports-as-admin
$apiUrl = "https://api.powerbi.com/v1.0/myorg/admin/reports"
$response = Invoke-RestMethod -Method Get -Uri $apiUrl -Headers $headers

$response.value | ft

# etc.
