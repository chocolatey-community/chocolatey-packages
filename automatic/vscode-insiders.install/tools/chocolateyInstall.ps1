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
  url            = 'https://az764295.vo.msecnd.net/insider/a5727468f373af49f785a94e13e7a2890a1097af/VSCodeSetup-ia32-1.80.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a5727468f373af49f785a94e13e7a2890a1097af/VSCodeSetup-x64-1.80.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '50efd63794b2d7caa0740ce6d3a721b16a48b35f32117a52617219214e258a379e0d985b51ce799131bcac452f623aa3ff16a5bb0836cd28fdb46a985cabc4b9'
  checksumType   = 'sha512'
  checksum64     = 'd0f66c859c52930fe038b7eff534562b964663ac277068b64c6d8b70369ec94c5a501b1d27bf76e4b999ea87df5857758a27a86337e7809e15681ac6b8459ad2'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
