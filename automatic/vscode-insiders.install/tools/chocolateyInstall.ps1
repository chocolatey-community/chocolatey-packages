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
  url            = 'https://az764295.vo.msecnd.net/insider/a803dc359aa1ed48c7acf074dd81d6af1525c8c8/VSCodeSetup-ia32-1.73.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a803dc359aa1ed48c7acf074dd81d6af1525c8c8/VSCodeSetup-x64-1.73.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'dbbad6a7e4761f8f3590fefc6a01f85411426db414ba700cbb56a522d9f6a35393494d5a207caa9670b1c8e53088628329611bc220193f758bc9e813000b57a5'
  checksumType   = 'sha512'
  checksum64     = '6640a74d943a6eadfb5f75bbf20d094cd7bf79dc471fc001b6e6305b298ef54c3d67e11bf3970bdc3c0a2b3c5a58b504202fcdb66d62bb94d613e045f042e332'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
