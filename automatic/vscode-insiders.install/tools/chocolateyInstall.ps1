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
  url            = 'https://az764295.vo.msecnd.net/insider/833ac685084e2028b09753392b82c641c7025bbc/VSCodeSetup-ia32-1.77.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/833ac685084e2028b09753392b82c641c7025bbc/VSCodeSetup-x64-1.77.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'f1ecce592d5a8ac4e9d752458646235797243a8ad93f0f65b740619598814b004de246f3cff2f7f91831ce39d88a0451c02b32c336db398c11552b8df574286f'
  checksumType   = 'sha512'
  checksum64     = '5eb0418bcbd8d9696df7515ab1535bcc4838d90fb329b1d3442a6e980199b5e659b1d3f544cace426b1793e4dd2f148e4b8132896340c330a7bdf4f76a9608d9'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
