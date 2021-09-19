$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$fileName = 'HostsMan_Setup.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'exe'
  file           = gi $toolsPath\$fileName
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'Hostsman*'
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsPath\$fileName -ea 0; if (Test-Path $toolsPath\$fileName) { sc "$toolsPath\$fileName.ignore" "" }
