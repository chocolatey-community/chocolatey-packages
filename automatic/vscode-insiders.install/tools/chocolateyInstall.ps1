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
  url            = 'https://az764295.vo.msecnd.net/insider/8e1235ee25e3aad3598ab58016c071b5596b826a/VSCodeSetup-ia32-1.73.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/8e1235ee25e3aad3598ab58016c071b5596b826a/VSCodeSetup-x64-1.73.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e4886df030059b1f7b22456a5bde0253920fa8c7859ba30fe76b52ded0d2337d7c1cc192630e6a4ebab8c3d883cb64a681224eae0f53e9957fd256b9d7d8695a'
  checksumType   = 'sha512'
  checksum64     = '7b97fe867ff86891a179ed8d0478237d161f6529254fd76b8573d2322088109857a398a31cc13d0f66ffcc1e553a0bfa4fc66fef0ca0b3f468f4613ce8376491'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
