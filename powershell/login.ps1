#-----------------------------------------------------
# login.ps1
#-----------------------------------------------------
# Ask for credentials
Add-PowerAppsAccount

# Alternatively: Here is how you can pass in credentials (avoiding opening a prompt) - works only without MFA!
# $pass = ConvertTo-SecureString "password" -AsPlainText -Force
# Add-PowerAppsAccount -Username foo@bar.com -Password $pass

