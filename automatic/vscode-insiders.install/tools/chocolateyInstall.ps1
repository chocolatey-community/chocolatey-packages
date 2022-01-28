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
  url            = 'https://az764295.vo.msecnd.net/insider/4af3e141defad7b6b96aa1e831f4b50f78abbe6d/VSCodeSetup-ia32-1.64.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/4af3e141defad7b6b96aa1e831f4b50f78abbe6d/VSCodeSetup-x64-1.64.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '46f634d005ac8792dd653061fd760665d1c0dfed93fa50cb28bd54c1e81cab2fd4d299a47d383beb850539d0fd47ab0ff867a11e03c410a5dfabe07e0b0c7ce5'
  checksumType   = 'sha512'
  checksum64     = 'ee966f83b03ddeb20efa52f3336354ddb122842f033a4659f213b831422a930e5212356463f1cf619e3b570421cfe17caf3c65470357163f6a4716d20c3bdfae'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
