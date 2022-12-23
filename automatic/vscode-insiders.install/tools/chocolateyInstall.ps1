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
  url            = 'https://az764295.vo.msecnd.net/insider/6ed4d436a9b6ae131732f4e2a723868231f4473a/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6ed4d436a9b6ae131732f4e2a723868231f4473a/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'fc0a79a1c77006de5e50952b3bf180542c8196a361bd6e9762d08c4f0ff5e23aa650e085377964d95aaa5d963e5a54eb291670f3276972399326c2fb23a35e1d'
  checksumType   = 'sha512'
  checksum64     = 'e9f043676e156251b0844b57d14c3d40d2ccc5d6e02efe1e1050bc84116189e04e626268c1875c1723bebe0291512e24050a4afba7eb330034ebb0047f348075'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
