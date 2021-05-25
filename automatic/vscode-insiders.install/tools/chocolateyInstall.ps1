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
  url            = 'https://az764295.vo.msecnd.net/insider/286b643ecd231f66f3f2e67e1456f3c601838b46/VSCodeSetup-ia32-1.57.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/286b643ecd231f66f3f2e67e1456f3c601838b46/VSCodeSetup-x64-1.57.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '85ee772e3d7e97abc80ba5b4ef3e573ae150a57e104b12a78ca40c1bb5365eaf36d50edf10d391565c0bd7f14edc44ffc3537c23db244729f150de58a0625b61'
  checksumType   = 'sha512'
  checksum64     = '57af64ebea9143bfbf40ab7073c6cc819fbb24b28f31421c2aeeff81d961969ab913b921da6d3d76cc5ec4bc648da4b25ba98685234bf919e353f44d330af631'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
