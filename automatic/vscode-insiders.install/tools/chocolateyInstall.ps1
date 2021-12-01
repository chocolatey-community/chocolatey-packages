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
  url            = 'https://az764295.vo.msecnd.net/insider/0cc0904c565399781defa830facf43141db8b6f3/VSCodeSetup-ia32-1.63.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/0cc0904c565399781defa830facf43141db8b6f3/VSCodeSetup-x64-1.63.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6c53bef17cda01f0050807b9da379706d2eec23e165b677b559475297cb00ac7830c70325993d5463ca2c98f55ac42e1bfa29168ce75f8744852b0880ed8ad24'
  checksumType   = 'sha512'
  checksum64     = 'adb596d4ed46565758ec4a44a01125a86adc2d4145a02f54dec3f91acd8b27e34e7f01b019b592ce885dc1387e7ed38b89f475565cc9116b42529af822945444'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
