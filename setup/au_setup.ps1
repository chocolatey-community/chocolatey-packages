@"
## Update Variables - AU
#
# This file is not checked in. It exists only locally.
# These same settings should be verified with appveyor.yml

# Job parameters
`$env:au_timeout      = '100'
`$env:au_threads      = '10'
`$env:au_push         = 'true'
`$env:au_force        = 'false'

# Github credentials - used to save result to gist and to commit pushed packages to the git repository
`$env:github_user     = 'YOUR_GITHUB_USERNAME_HERE'
`$env:github_pass     = 'YOUR_PASSWORD_OR_2FA_AUTH_TOKEN_HERE'
`$env:github_user_repo= 'YOUR_GITHUB_USERNAME_HERE/chocolatey-packages'  #https://github.com/chocolatey/chocolatey-packages-template is 'chocolatey/chocolatey-packages-template'

# Email credentials - for error notifications
`$env:mail_user       = 'YOUR_EMAIL_ACCOUNT'
`$env:mail_pass       = 'YOUR_EMAIL_PASSWORD_HERE'
`$env:mail_server     = 'smtp.gmail.com'
`$env:mail_port       = '587'
`$env:mail_enablessl  = 'true'

# Chocolatey API key - to push updated packages
`$env:api_key         = 'YOUR_CHOCO_API_KEY_HERE'

# ID of the gist used to save run results - create a gist under the github_user (secret or not) and grab the id - https://gist.github.com/name/id
`$env:gist_id         = 'YOUR_GIST_ID_CREATE_GIST_SAVE_ID_HERE'
"@ | Out-File $PSScriptRoot\..\au\update_vars.ps1 -NoClobber

#
# Uncomment these next lines if you are using AU
# and have WMF3+ installed.
# Otherwise you need to find a way to install PowerShell PackageManagement

# WMF 3/4 only
if ($PSVersionTable.PSVersion -lt $(New-Object System.Version("5.0.0.0"))) {
  choco install dotnet4.5.1 -y
  choco upgrade powershell-packagemanagement --ignore-dependencies -y
}

choco install ruby -y
$refreshenv = Get-Command refreshenv -ea SilentlyContinue
if ($refreshenv -ne $null -and $refreshenv.CommandType -ne 'Application') {
  refreshenv # You need the Chocolatey profile installed for this to work properly (Choco v0.9.10.0+).
} else {
  Write-Warning "We detected that you do not have the Chocolatey PowerShell profile installed, which is necessary for 'refreshenv' to work in PowerShell."
}

$gem = Get-Command gem -ea SilentlyContinue
if ($gem -eq $null) {
  Write-Warning "You will need to close and reopen your shell, then run 'gem install gist --no-ri --no-rdoc'"
} else {
  gem install gist --no-ri --no-rdoc
}

Install-PackageProvider -Name NuGet -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module au -Scope AllUsers
Get-Module au -ListAvailable | select Name, Version
