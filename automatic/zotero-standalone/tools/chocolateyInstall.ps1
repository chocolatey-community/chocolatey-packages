$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'zotero-standalone'
  fileType       = 'exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Zotero Standalone *'
  file           = "$toolsPath\Zotero-5.0.33_setup.exe"
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
