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
  url            = 'https://az764295.vo.msecnd.net/insider/eaa2b431ac259fddf5aa11aa53060a9b70068b29/VSCodeSetup-ia32-1.66.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/eaa2b431ac259fddf5aa11aa53060a9b70068b29/VSCodeSetup-x64-1.66.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7c4027fb21189af9c637d8e1504e265f03cd2d5241b61226d3fbce8d257972f7c63e7f8877a36b46640a973ea12e43347388e829f822103a47429aa9f9c0e0e9'
  checksumType   = 'sha512'
  checksum64     = 'cfaaf0f5ca1fa31565842cd8f5b942fbb58a7f9a356c0aaf524ce4dfa9f65dd2ea4f35e991806917e6dd432e85ceb4ac18eaa830a0ce779fea5e5a043c3cc73b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
