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
  url            = 'https://az764295.vo.msecnd.net/insider/6384e3246884694cbc34eacc70281ada15e2c7f2/VSCodeSetup-ia32-1.49.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6384e3246884694cbc34eacc70281ada15e2c7f2/VSCodeSetup-x64-1.49.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '9aafd359184b4961c33ec5706ccf402ead39a4fd7ff40da507ec54b529c8d90d3bbb5f3ee46ac534c916c09c4573bd7f25ebd0fab7d7c4887384618e9e0f9d16'
  checksumType   = 'sha512'
  checksum64     = '29ba0ab183124539165e11ef8f28ded0a806d4b9cebe4946334ddf3daf191bee5733c9b490a4c4d77f62fb23cd17fc207a01d5f1b4dbe0eb957764f6310182ec'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
