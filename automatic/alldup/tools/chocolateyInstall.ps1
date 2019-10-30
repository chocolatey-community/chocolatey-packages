$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = $fileType
  file           = Get-Item $toolsPath\*.exe
  silentArgs     = '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG="{0}/InnoInstall.log"' -f (Get-PackageCacheLocation)
  validExitCodes = @(0)
  softwareName   = 'AllDup*'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"

Remove-Process -PathFilter alldup.exe -WaitFor 10 | Out-Null
