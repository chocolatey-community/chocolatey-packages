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
  url            = 'https://az764295.vo.msecnd.net/insider/cad4c193d85f0891204da41c0508de39e7aa38c6/VSCodeSetup-ia32-1.62.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/cad4c193d85f0891204da41c0508de39e7aa38c6/VSCodeSetup-x64-1.62.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'a2338d19a09f476a0421859c60a1f058b93ef7cb7a28105787433a8f362540dd5406b2602bd0465f221f93fa87ae2aebd87e02439a7149b00e5748dc88f82e74'
  checksumType   = 'sha512'
  checksum64     = '1e3b517d90866d181217c277b3ac03f90d16db48e217cf1578b9c5721379a54cfb159da145975f404de107a5ec71bd2f74774756e3848be2c894ce47f3731436'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
