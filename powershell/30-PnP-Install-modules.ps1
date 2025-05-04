#---------------------------------------
# 30-PnP-Install-modules.ps1
# atwork.at, Toni Pohl
#---------------------------------------

# https://pnp.github.io/powershell/articles/installation.html
# https://blog.atwork.at/post/Copy-SharePoint-list-with-PowerShell
$env:PSModulePath -split ';'

Install-Module -Name PnP.PowerShell -Scope CurrentUser

# Install-Module -Name Microsoft.Graph
Install-Module -Name Microsoft.Graph.Authentication -Scope CurrentUser
Install-Module -Name Microsoft.Graph.Applications -Scope CurrentUser
Install-Module -Name Microsoft.Graph.Sites -Scope CurrentUser   

# Install-Module -Name Az
Install-Module -Name Az.Accounts -AllowClobber -Scope CurrentUser
Install-Module -Name Az.Keyvault -Scope CurrentUser

# if needed:
# Update-Module -Name PnP.PowerShell -Scope CurrentUser
# Update-Module -Name Microsoft.Graph.Authentication
# Update-Module -Name Microsoft.Graph.Applications 

# End.