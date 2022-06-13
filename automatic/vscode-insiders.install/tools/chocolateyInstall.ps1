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
  url            = 'https://az764295.vo.msecnd.net/insider/53130238b422606ffcd616126fb8c6c81c6e4436/VSCodeSetup-ia32-1.69.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/53130238b422606ffcd616126fb8c6c81c6e4436/VSCodeSetup-x64-1.69.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'bc3964acaf99de9fdc284e77af3ad09a28edb50c5b65a05a3071f16b141705a99137aae945bd7a6c65797f3ba029ed3cafbc69ae6b126690d44d1aa2d6cdab59'
  checksumType   = 'sha512'
  checksum64     = '9b933608d302f495b8322c41499121e1b913c2beeba18d9f9da92bf728b9ff70071985b3471bffcc87c0cbdcd6ee759dcea2fcde509e235a31de8def16504e6b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
