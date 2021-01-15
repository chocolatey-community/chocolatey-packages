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
  url            = 'https://az764295.vo.msecnd.net/insider/1a6eef3170be2a11751ee50d450328d458f7bfac/VSCodeSetup-ia32-1.53.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/1a6eef3170be2a11751ee50d450328d458f7bfac/VSCodeSetup-x64-1.53.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'c366ce63e8a77d0266344d6b47ca0e0d3cdc961ed5b047a32bc73d73430d4c8df22039e3782342f4b677b57eefba2337996759552f7aed392a1887969a2fae1c'
  checksumType   = 'sha512'
  checksum64     = '30f1dd0caf09b39c5e60c47bf407e4724caadb90a5f58d83b85a424292b6a075f8bf6502a0abd79425c5dd44af9bd1bd7aae0d760dc68246a4e22f82605dc699'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
