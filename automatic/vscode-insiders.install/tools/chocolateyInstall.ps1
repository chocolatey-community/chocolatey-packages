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
  url            = 'https://az764295.vo.msecnd.net/insider/93f705ab40b37aade9d3b5165ed09114a8c87ac9/VSCodeSetup-ia32-1.54.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/93f705ab40b37aade9d3b5165ed09114a8c87ac9/VSCodeSetup-x64-1.54.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3baa554cad3c03d7325dc7dd38a7aa709cfcc0ed5e1e01db96c739e1ae57e43b55f3908870aa20c3bbbdf54be2f935bfa0414f67ae89573e594e9aac9185ff80'
  checksumType   = 'sha512'
  checksum64     = 'f7328e7a35e6243b69d0c9d02b83787ba0864ba2e0139e0a341835eebe73f311ff2cff09e3ae28c7e8ffb12f3cfa3f22af133b8ecdff6562ddf85f016bf32891'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
