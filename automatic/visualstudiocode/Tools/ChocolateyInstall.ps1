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
$url32 = 'https://az764295.vo.msecnd.net/stable/376c52b955428d205459bea6619fc161fc8faacf/VSCodeSetup-ia32-1.13.0.exe'
$url64 = 'https://az764295.vo.msecnd.net/stable/376c52b955428d205459bea6619fc161fc8faacf/VSCodeSetup-ia32-1.13.0.exe'
$checksum32 = '997e8ab5229449448469800fa3de868857a9bdbdd1cc1c9394031d3c142126cf'
$checksum64 = '997e8ab5229449448469800fa3de868857a9bdbdd1cc1c9394031d3c142126cf'

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
