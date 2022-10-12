$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

Close-VSCodeInsiders

$pp = Get-PackageParameters
function Get-MergeTasks {
  $t = "!runCode"
  $t += ', ' + '!' * $pp.NoDesktopIcon + 'desktopicon'
  $t += ', ' + '!' * $pp.NoQuicklaunchIcon + 'quicklaunchicon'
  $t += ', ' + '!' * $pp.NoContextMenuFiles + 'addcontextmenufiles'
  $t += ', ' + '!' * $pp.NoContextMenuFolders + 'addcontextmenufolders'
  $t += ', ' + '!' * $pp.DontAssociateWithFiles + 'associatewithfiles'
  $t += ', ' + '!' * $pp.DontAddToPath + 'addtopath'

  Write-Host "Merge Tasks: $t"
  $t
}

$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/insider/56f631257cfafdd76acbf062654ae4d8ad32e221/VSCodeSetup-ia32-1.73.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/56f631257cfafdd76acbf062654ae4d8ad32e221/VSCodeSetup-x64-1.73.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'fae5a653000ab8455ddc446e387f52b948ad72d176f6110d75f19d26c909c438d750ba5f7525837befd1f2b76fd8d33bc6745b4f7752a8cbc978c251b3afe724'
  checksumType   = 'sha512'
  checksum64     = '2c6e44c08a63cd635bc5c5ed2b458cb2e93afb677aaea4df7f09db191829cf8a1941a39f7d1957a3b871b9dc5a389341de1ccbd1595ab3b08b0fa0e9ed4708aa'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
