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
  url            = 'https://az764295.vo.msecnd.net/insider/493a541735b84de36b628750ba716a430669cb7f/VSCodeSetup-ia32-1.74.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/493a541735b84de36b628750ba716a430669cb7f/VSCodeSetup-x64-1.74.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '769dbd903d8bab7991760cae53685d068bc3c96db4e5f2288e0cf7995782b64af833a16dd7c0a591dd2470db4474630f07d0cf390fb8ad96e2a709e9d13d7276'
  checksumType   = 'sha512'
  checksum64     = 'af6e6ff49691e39dfda9fb71dc42ae38d8cd99248679ca4c8d8ae3aea98704d3353b0a3160dc1cdbf703d7c6e123c498081696bfe7591ed0bc01fffeaa08d833'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
