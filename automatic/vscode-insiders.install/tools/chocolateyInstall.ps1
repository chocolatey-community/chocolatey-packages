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
  url            = 'https://az764295.vo.msecnd.net/insider/266ff5b78fc4a128994194e828e55b2bbeb0acbe/VSCodeSetup-ia32-1.73.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/266ff5b78fc4a128994194e828e55b2bbeb0acbe/VSCodeSetup-x64-1.73.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '1b6a0c21140478fa9fd346379ef750a7f41c4ba64e359a2cf5ceb8de56f78a7285750bd11465ba52abf3bb89500e11803fb136c367fc8c8772e9fff730a00208'
  checksumType   = 'sha512'
  checksum64     = 'b461993733bdcd74d31dab7e8270d133472b5da5cb37b0a7c851f7bddaf7ebb04e422ec57f745d9d3bcb44f4d571650b7b8e9a0d75383a1b46fa03e0f4d46314'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
