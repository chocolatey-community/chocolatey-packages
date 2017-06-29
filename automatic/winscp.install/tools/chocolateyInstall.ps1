$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$pp = Get-PackageParameters

$packageArgs = @{
  packageName    = 'winscp'
  fileType       = 'exe'
  file           = gi $toolsPath\*.exe
  file64         = gi $toolsPath\*.exe
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { touch "$_.ignore" }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Install-BinFile $packageName "$installLocation\$packageName.exe"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
