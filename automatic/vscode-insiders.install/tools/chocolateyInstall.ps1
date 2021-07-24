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
  url            = 'https://az764295.vo.msecnd.net/insider/04485223ebc6a075f39966bf9b3e261359ac7818/VSCodeSetup-ia32-1.59.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/04485223ebc6a075f39966bf9b3e261359ac7818/VSCodeSetup-x64-1.59.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'c7a8c751d15c88385b636b6976827f4c756764a0f95f03f914c3c7f572090594ad888a3ee6a6defc293883810054d5ce792737a88cdb4b9ae9625baafbb6fada'
  checksumType   = 'sha512'
  checksum64     = '93a74d2aa300935c703d3f04c1aa4264f97feec9d35eaba6cd4a015f7c28673f9c3f148145598379e38d3451417a8ba6cd5028640856c18b44e2c54889c16ca2'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
