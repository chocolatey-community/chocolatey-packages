$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$file = if ($pp.Light) { gi $toolsPath\*lite* } else { gi $toolsPath\*full* }

$packageArgs = @{
  packageName    = 'winamp'
  fileType       = 'exe'
  file           = $file
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Winamp'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}