$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$version = "3.1.1"

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\Pencil-$version.ga.exe"
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Pencil*'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}
