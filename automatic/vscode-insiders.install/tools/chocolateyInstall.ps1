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
  url            = 'https://az764295.vo.msecnd.net/insider/bfac07cd0e374c433c2c06d6999dabf9cf9d5d29/VSCodeSetup-ia32-1.58.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/bfac07cd0e374c433c2c06d6999dabf9cf9d5d29/VSCodeSetup-x64-1.58.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '0221958fe55428c367c57d177f150ce945124fb8b7aeed5484dd148e2aca7e7d4298ad0e26cc1771dbdef38f4e38225d616431d0bfeeefd02045b507ca18dfd4'
  checksumType   = 'sha512'
  checksum64     = 'eaa0c2bf0970f71daadb2cc170b2eccc3351eb27fedc72aeb11887f08e594ce04f26acd263cf53cea879fcee021ee4c3aed0e2b09ee30e720f4c690f796b0624'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
