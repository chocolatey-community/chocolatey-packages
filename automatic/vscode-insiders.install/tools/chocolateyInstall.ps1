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
  url            = 'https://az764295.vo.msecnd.net/insider/caf01baa45b9816e2e1d8a2de22b40cf89459c03/VSCodeSetup-ia32-1.52.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/caf01baa45b9816e2e1d8a2de22b40cf89459c03/VSCodeSetup-x64-1.52.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3005b47eb78f5453ee25d479066d778993639705c8a85fac70705b3c565152f36dec5df3e28e9b9b1633d531604a8d09e0b59396546fe7d19d8f7884844db467'
  checksumType   = 'sha512'
  checksum64     = 'e6c91a9ba0c62eecea7e9844a3044f3f2f1237415964f3a0f99754d024f627cd2bbc21e87ebe43222f40448ac9e2f507d5854974a02328f3a036b4b531fbfaba'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
