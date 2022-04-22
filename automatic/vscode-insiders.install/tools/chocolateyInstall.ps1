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
  url            = 'https://az764295.vo.msecnd.net/insider/72b4be55fad0d41092d7df8e03b5597c715fd2e2/VSCodeSetup-ia32-1.67.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/72b4be55fad0d41092d7df8e03b5597c715fd2e2/VSCodeSetup-x64-1.67.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '89cb3a0fe0794153bbbd039e3f1cb92c1fdb4ac29734099e524ba5e6ed2d4ead70627253b9a5d55ff67569fa1228a502e232b1b6361c7ae536efc0c0d31aad34'
  checksumType   = 'sha512'
  checksum64     = '6e11ccddcdd5b2738de3bfb09514dbc29d9d78d3cbf8b0e639d8497742a3ef9d6d571c6b25b63b2d806f07d70327dfeb5fda643e376db4ad3f46f6819a113fd5'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
