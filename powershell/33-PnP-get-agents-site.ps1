#-------------------------------------------
# 33-PnP-get-agents.ps1
# atwork.at, Toni Pohl
#-------------------------------------------
# Get a Copilot agent insight report for the specified number of days.

# https://learn.microsoft.com/en-us/powershell/module/sharepoint-online/?view=sharepoint-ps
# https://learn.microsoft.com/en-us/powershell/module/sharepoint-online/start-spocopilotagentinsightsreport?view=sharepoint-ps
# Alternative (Cross-platform) Option:
# If you must use PowerShell 7, consider using the newer PnP.PowerShell module, which is compatible with PowerShell 7 and provides much broader functionality:
# https://pnp.github.io/script-samples/spo-get-agent-list/README.html?tabs=pnpps

$url = "https://<your-tenant>.sharepoint.com/sites/<your-site>"
$fileLocation = ".\SharePointAgentFiles.csv"

Connect-PnPOnline -Url $url -UseWebLogin 

# Get all document libraries excluding system libraries
$documentLibraries = Get-PnPList | Where-Object {
    $_.BaseTemplate -eq 101 -and
    $_.Hidden -eq $false -and
    $_.Title -notmatch "Form Templates|Style Library|Site Pages"
}

$allAgentFiles = @()
foreach ($library in $documentLibraries) {

    # Extract all agent files from the library, basically all files with .agent extension. FieldValues contains all the metadata of the file.
    $files = Get-PnPListItem -List $library.Title | Where-Object { $_["FileLeafRef"] -like "*.agent" } | select-object  FieldValues

     foreach ($file in $files) {

        $fileUrl = $file.FieldValues["FileRef"]
        $fileContent = Get-PnPFile -Url $fileUrl -AsString
        $jsonData = $fileContent | ConvertFrom-Json

        $agentData = [PSCustomObject]@{
                    FileName              = $file.FieldValues["FileLeafRef"]
                    FilePath              = $fileUrl
                    SchemaVersion         = $jsonData.schemaVersion
                    CopilotName           = $jsonData.customCopilotConfig.gptDefinition.name
                    Description           = $jsonData.customCopilotConfig.gptDefinition.description
                    Instructions          = $jsonData.customCopilotConfig.gptDefinition.instructions
                    WelcomeMessage        = $jsonData.customCopilotConfig.conversationStarters.welcomeMessage.text
                    ConversationStarters  = ($jsonData.customCopilotConfig.conversationStarters.conversationStarterList.text -join "; ")
                    Capabilities          = ($jsonData.customCopilotConfig.gptDefinition.capabilities.name -join "; ")
                    ReferencedURLs        = ($jsonData.customCopilotConfig.gptDefinition.capabilities.items_by_url.url -join "; ")
                    SiteIDs               = ($jsonData.customCopilotConfig.gptDefinition.capabilities.items_by_url.site_id -join "; ")
                    WebIDs                = ($jsonData.customCopilotConfig.gptDefinition.capabilities.items_by_url.web_id -join "; ")
                    ListIDs               = ($jsonData.customCopilotConfig.gptDefinition.capabilities.items_by_url.list_id -join "; ")
                    UniqueIDs             = ($jsonData.customCopilotConfig.gptDefinition.capabilities.items_by_url.unique_id -join "; ")
                }

        $allAgentFiles += $agentData
     }
}

$allAgentFiles | Export-Csv -Path $fileLocation -NoTypeInformation

Write-Host $fileLocation

# End.
