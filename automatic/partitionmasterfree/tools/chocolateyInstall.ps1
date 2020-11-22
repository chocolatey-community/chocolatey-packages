$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\epm_free_A_easeus.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 3010)
  softwareName   = 'EaseUS Partition Master*'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}

Ensure-NotRunning
