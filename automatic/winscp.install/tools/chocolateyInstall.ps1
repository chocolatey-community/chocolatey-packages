$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'winscp'
  fileType       = 'exe'
  file           = "$toolsPath\WinSCP-6.3.5-Setup.exe"
  file64         = "$toolsPath\WinSCP-6.3.5-Setup.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Install-BinFile $packageName "$installLocation\$packageName.exe"
Install-BinFile "${packageName}.com" "${installLocation}\${packageName}.com"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
