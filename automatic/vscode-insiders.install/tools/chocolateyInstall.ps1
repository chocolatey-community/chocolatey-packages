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
  url            = 'https://az764295.vo.msecnd.net/insider/acb156d6fb0dc451f427748d5f68774f17cc96fd/VSCodeSetup-ia32-1.68.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/acb156d6fb0dc451f427748d5f68774f17cc96fd/VSCodeSetup-x64-1.68.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '288a721d29307183389b3864827e93e29d8d705964a0a4a9c9acb69296c922457c9476132bc6571e02f9dcaf33969e81615d9e90938d0c119b6c0dfde559b97c'
  checksumType   = 'sha512'
  checksum64     = 'ccd4e787ec0c0b1800676b59f6a437b167b7dc7d158d8d3cad1065ae0d95a3dd2485460f235d71917f4a690197f2cd3717a0114e1745bf196ac020ca528d45e9'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
