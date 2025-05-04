#-----------------------------------------------
# 31-PnP-CreateApplication.ps1
# atwork.at, Christoph Wilfing
# Create an Entra ID app and certificate for PnP
#-----------------------------------------------

#requires -Modules Microsoft.Graph.Authentication
#requires -Modules Microsoft.Graph.Applications

# Create the Entra ID application
$arrLoginScopes = @('Directory.read.all', 'Application.ReadWrite.All')
# Define the API permissions for the new app
#$arrApplicationScopes = @('Sites.Selected')
$arrApplicationScopes = @('Sites.FullControl.All', 'Sites.Read.All', 'Sites.ReadWrite.All', 'Sites.Manage.All', 'Sites.Selected')
$TenantName = '<your-tenant>.onmicrosoft.com'
$AppName = 'PnP-NewAuth-App'

#Write-Host 'Connecting to graph powershell...' -NoNewline
Connect-MgGraph `
    -Scopes $arrLoginScopes `
    -TenantId $TenantName `
    -ContextScope Process `
    -UseDeviceAuthentication
    
Write-Host 'Signed-in.' -ForegroundColor Green

$arrRequiredResourceAccess = New-Object -TypeName System.Collections.arraylist

#region Graph permissions
Write-Host 'Compiling Graph permissions...' -NoNewline
$arrResourceAccess = New-Object -TypeName System.Collections.arraylist
$GraphApi = Get-MgServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"
foreach ($Permission in $arrApplicationScopes) {
    $GraphPermission = $GraphApi.AppRoles | Where-Object { $PSItem.Value -eq $Permission }
    [void]$arrResourceAccess.Add(@{
            Id   = $GraphPermission.Id
            Type = 'Role'
        })
}

[void]$arrRequiredResourceAccess.add(@{
        resourceAppId  = $GraphApi.AppId
        resourceAccess = $arrResourceAccess.ToArray()
    })

$objDomain = Get-MgDomain | `
    Where-Object { $PSItem.Id -like '*.onmicrosoft.com' } | `
    Select-Object -First 1
$strTenantName = $objDomain.Id.Split('.')[0]
Write-Host 'Done' -ForegroundColor Green
#endregion

#region Create Application
Write-Host 'Creating application $AppName...' -NoNewline
$web = @{
    RedirectUris = "https://$strTenantName-admin.sharepoint.com/"
}

$params = @{
    DisplayName            = $AppName
    Web                    = $web
    requiredResourceAccess = $arrRequiredResourceAccess.ToArray()
    SignInAudience         = 'AzureADMyOrg'
}

$objApplication = New-MgApplication @params
Write-Host 'Done' -ForegroundColor Green
#endregion

# We use a cert from Key Vault.... N
$strAnswer = Read-Host -Prompt 'Create Certificate for App? (Y => Certificate / N => Password)'

if ($strAnswer -eq 'Y') {
    #region create certificate to authenticate
    # Number of years of certificate validity
    Write-Host 'Creating Certificate...' -NoNewline
    $certYears = 2

    ## Certificate (PFX) password
    $Cert = New-SelfSignedCertificate `
        -NotAfter $(Get-Date).AddYears($certYears) `
        -Type SSLServerAuthentication `
        -FriendlyName $appName `
        -Subject "CN=$appName" `
        -CertStoreLocation 'Cert:\CurrentUser\My' `
        -KeySpec KeyExchange

    # Create a keyCredential hash table for use in the cmdlet 
    $keyCreds = @{ 
        Type  = 'AsymmetricX509Cert';
        Usage = 'Verify';
        key   = $Cert.GetRawCertData()
    }

    Update-MgApplication `
        -ApplicationId $objApplication.Id `
        -KeyCredentials $keyCreds
    Write-Host 'Done' -ForegroundColor Green
    #endregion
} else {
    #region Create a hashtable for the password credential
    Write-Host 'Creating password credential...' -NoNewline
    $objPasswordCred = @{
        displayName = 'Created in PowerShell for Login'
        endDateTime = (Get-Date).AddMonths(12)
    }

    # Add the password credential to the application
    $objSecret = Add-MgApplicationPassword -ApplicationId $objApplication.Id -PasswordCredential $objPasswordCred
    Write-Host 'Done' -ForegroundColor Green
    #endregion
}

#region Consent Url

## Browse this URL
Write-Host 'Please open a browser with the following URL as an Administrator to consent to the application permissions:'
Write-Host '(We copied the URL to your clipboard.)'
$consentURL = "https://login.microsoftonline.com/$TenantName/adminconsent?client_id=$($objApplication.AppId)"
Write-Host "URL: $consentURL" -ForegroundColor Green
Set-Clipboard -Value $consentURL

Write-Host '--------------------------------------------------------------------------------'
Write-Host "Application (Client) Id: $($objApplication.AppId)"
Write-Host "Application Secret: $($objSecret.SecretText)"
Write-Host "TenantId: $((Get-MgContext).TenantId)"
Write-Host '--------------------------------------------------------------------------------'

# End.
