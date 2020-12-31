$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keeweb'
  fileType       = 'exe'
  file           = "$toolsPath\KeeWeb-1.16.7.win.ia32.exe"
  file64         = "$toolsPath\KeeWeb-1.16.7.win.x64.exe"
  softwareName   = 'keeweb*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
