$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = Get-Item $toolsDir\*_x32.exe

$packageArgs = @{
  packageName    = 'womic'
  fileType       = 'exe'
  softwareName   = 'WO Mic*'
  file           = $filePath
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -ea 0 -force

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find WO Mic install location"; return }
Write-Host "WO Mic installed to '$installLocation'"

# Register the bin file for the client
Install-BinFile 'WO Mic' $installLocation\WOMicClient.exe