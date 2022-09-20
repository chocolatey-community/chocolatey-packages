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
  url            = 'https://az764295.vo.msecnd.net/insider/a829fbb91cbae44afb6a389341a0763fb3a6ac6f/VSCodeSetup-ia32-1.72.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a829fbb91cbae44afb6a389341a0763fb3a6ac6f/VSCodeSetup-x64-1.72.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '67bfc30b200fc3d70c7ad24568cd3d12486b19676c6ebbe08e02a94cd7ebdab6f33bc47816d56f405bff34eb713f49f10b553595301066b4b5acd35e1372ddbf'
  checksumType   = 'sha512'
  checksum64     = '50d3171a53d9e4745b980d6a40307456acbe5ab2387bad3853561635ebfa5e1feb8b17cfc4aa23947bb9c388b9ed4dc1fb56f3e8fe6de890b6d140f1c736f02c'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
