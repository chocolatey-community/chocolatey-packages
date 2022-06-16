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
  url            = 'https://az764295.vo.msecnd.net/insider/6f7c824a826ff0ccaf4de05d6fe0aac3be7bc136/VSCodeSetup-ia32-1.69.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6f7c824a826ff0ccaf4de05d6fe0aac3be7bc136/VSCodeSetup-x64-1.69.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6b1863d26412a2492ca90eb828703e8a4d32b8cbb3fab9306476c1a95a0bca35e0f27115b20e91f44c9425a8ac9f982c2699d2211f1955d0cc818526bd4d60f3'
  checksumType   = 'sha512'
  checksum64     = '6ee1d9b72c54494d1399a971d124be4d5328d3ef553f4f226247997ddf8e29d677e03d3c747ed9de5f538385cbb5dfbcc2b801505d2b85f16a7c36e2a90cde57'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
