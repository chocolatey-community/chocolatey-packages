$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'mattermost-desktop'
  fileType       = 'exe'
  file           = "$toolsPath\mattermost-setup-4.1.0-win32.exe"
  file64         = "$toolsPath\mattermost-setup-4.1.0-win64.exe"
  softwareName   = 'Mattermost*'
  # This is still Squirrel being used. Lets use --silent.
  silentArgs     = '/S --silent'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsPath\*.exe | % { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }