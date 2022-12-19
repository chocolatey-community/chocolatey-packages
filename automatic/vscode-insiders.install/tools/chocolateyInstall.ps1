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
  url            = 'https://az764295.vo.msecnd.net/insider/64a739f7aa1092187348afa9378931d47683be12/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/64a739f7aa1092187348afa9378931d47683be12/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '5aaf19da1f9c01a34b33fd417f4141fe6a004465d0f922daf1fbda740921e47aa0cc4057d55de0a47bfb811c48af0dc17986ab3519db9c6812acd7a2b6d76b0b'
  checksumType   = 'sha512'
  checksum64     = '850bfeab63cdf9827a8ce0cefd56050a235f4c8710ae15c86d6db89a24515e0f8d2bfb2e0e0c30e8c01a6920926ef00221f1ea6a19d3f19d4e91c524d10654b0'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
