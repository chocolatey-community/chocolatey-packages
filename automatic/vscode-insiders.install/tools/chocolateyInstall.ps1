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
  url            = 'https://az764295.vo.msecnd.net/insider/a5bd844beddef8ca5f9ccfdb1bb7b3b4f8e5204e/VSCodeSetup-ia32-1.77.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a5bd844beddef8ca5f9ccfdb1bb7b3b4f8e5204e/VSCodeSetup-x64-1.77.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '805a6d3438c6bd1cfb22476bf22599a5ea4316f4ca92597d2e8fd685fed7e0a662e744c76a95e23c1f4a863777d9237cc218fa667f1effc5ad174ff345438e37'
  checksumType   = 'sha512'
  checksum64     = '007f3f7331181f3eacdd6a956f6c528c58ae15d96e15dddd77df497f6ac6a0f545bb8f9dbced7232e7fc4c4514c135d37cd4528b41b224a0632b4775ad2c0251'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
