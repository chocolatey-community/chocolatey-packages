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
  url            = 'https://az764295.vo.msecnd.net/insider/521a3d858570ebc9ce9d5602802f4525a02e045c/VSCodeSetup-ia32-1.66.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/521a3d858570ebc9ce9d5602802f4525a02e045c/VSCodeSetup-x64-1.66.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '5e847162fa15ec6a89cc90ee8e3a9796b395468593e0857a770344014d15eebc385f81c668efce88a17b8477d76e6432dd83e92c496161a1262fce863d05b052'
  checksumType   = 'sha512'
  checksum64     = '0a343892f45979098d9281fe990f41a55eb8f98551a5a4a417dcdf046d83c9dd5c6fed24e100b35040a7bc20b1344224cdf90b1a00917b05c8c01219ed67e7ef'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
