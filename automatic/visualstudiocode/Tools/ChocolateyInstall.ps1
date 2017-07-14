$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters
$mergeTasks = "!runCode"
$mergeTasks += if ($pp.NoDesktopIcon) { ',!desktopicon' } else { ',desktopicon' }
$mergeTasks += if ($pp.NoQuicklaunchIcon) { ',!quicklaunchicon' } else { ',quicklaunchicon' } 
$mergeTasks += if ($pp.NoContextMenuFiles) { ',!addcontextmenufiles' } else { ',addcontextmenufiles' }
$mergeTasks += if ($pp.NoContextMenuFolders) { ',!addcontextmenufolders' } else { ',addcontextmenufolders' }
$mergeTasks += if ($pp.DontAddToPath) { ',!addtopath' } else { ',addtopath' }
Write-Host "Merge Tasks: "
Write-Host "$mergeTasks"

$packageName = 'visualstudiocode'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32 = 'https://az764295.vo.msecnd.net/stable/2648980a697a4c8fb5777dcfb2ab110cec8a2f58/VSCodeSetup-ia32-1.14.1.exe'
$url64 = 'https://az764295.vo.msecnd.net/stable/2648980a697a4c8fb5777dcfb2ab110cec8a2f58/VSCodeSetup-ia32-1.14.1.exe'
$checksum32 = '8984da56c3c16f9d76ebb626dd3bce02fc56c18306460b092340003694308a38'
$checksum64 = '8984da56c3c16f9d76ebb626dd3bce02fc56c18306460b092340003694308a38'

$packageArgs = @{
  packageName = $packageName
  unzipLocation = $toolsDir
  fileType = 'EXE'
  url = $url32
  url64bit = $url64

  softwareName = 'Microsoft Visual Studio Code'

  checksum = $checksum32
  checksumType = 'sha256'
  checksum64 = $checksum64
  checksumType64 = 'sha256'

  silentArgs = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
