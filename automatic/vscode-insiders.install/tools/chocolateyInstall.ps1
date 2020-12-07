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
  url            = 'https://az764295.vo.msecnd.net/insider/532ba43c78c82b24bdf94f9edde30cdf9b9bfa12/VSCodeSetup-ia32-1.52.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/532ba43c78c82b24bdf94f9edde30cdf9b9bfa12/VSCodeSetup-x64-1.52.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'fe94a0dd4307e031c8e1805b0996cd1f9d7b3e3a1e0918f912059ba705c989cce3d6e067732efb1c12ab06a53dde25e2e40210c2a5ff5ce47f3f17fdf2ed09d9'
  checksumType   = 'sha512'
  checksum64     = 'e061bfbc51db96322e6463307e082fbc3ab658630022c1b461ba0aaf3c2068363f2ce73d192cd604159ca1286d928b3341921439b09520bece9e49f8c9d5dc7f'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
