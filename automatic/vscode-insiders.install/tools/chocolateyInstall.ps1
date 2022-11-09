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
  url            = 'https://az764295.vo.msecnd.net/insider/96db0b339360bc72d27d869d81a557540ad5f800/VSCodeSetup-ia32-1.74.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/96db0b339360bc72d27d869d81a557540ad5f800/VSCodeSetup-x64-1.74.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'cbc5631c5e8c88476732f54d9c4ff6f93c807c9bcb503461a6e234e19999d0d88bf5890f599dd4a055e2d0a04fedff39c5aa2b46dd563aded33b27c3a4dd57ce'
  checksumType   = 'sha512'
  checksum64     = '74f15ab53939b1552a43a94dab8c43a2c4af93c97d12b2b55e4f616d812d351f6c6b158fbcee77b0eea5840f51da25a2614c2720dfbd192edc856e595bec0966'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
