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
  url            = 'https://az764295.vo.msecnd.net/insider/53aff5e347865fe22f9487ebd54dec9db23773b2/VSCodeSetup-ia32-1.61.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/53aff5e347865fe22f9487ebd54dec9db23773b2/VSCodeSetup-x64-1.61.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6612ebace2f9e87a856252f5627afb4b8dec6c7e218538961bd4d2a6c0da62e662b2cf59ea52e027d91883ac30d4af1986594d96609d305ff9c87ba99e4e505f'
  checksumType   = 'sha512'
  checksum64     = '49d3810eeb943e5a4989eab9ef0db8cb9124451ba125690f089dff6d5104bc1388e0bb0ef7b88a33974473cf2e233b3ef44f75c666c769bf0eec5ff7ed81c43d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
