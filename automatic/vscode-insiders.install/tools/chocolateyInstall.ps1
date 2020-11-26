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
  url            = 'https://az764295.vo.msecnd.net/insider/0a80aacc7be1ab03ec0f94b8ac1a84949a83f35d/VSCodeSetup-ia32-1.52.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/0a80aacc7be1ab03ec0f94b8ac1a84949a83f35d/VSCodeSetup-x64-1.52.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '99215e973ef6400304be444aeab59c83ce90e1e8e7e200f82b6c74ad2ee3ff2208646276a41f04e9643c2d23e2c133321749ac8c64b26f9b6f81315a2d0f4688'
  checksumType   = 'sha512'
  checksum64     = 'c9d85077ad63be783802928e812587cf2fffb61b4851fd8d5cf7120ea3503b15bbf3e35be00e4b57811870e91478549b9b566f438e839494a56407b44e9dd9e4'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
