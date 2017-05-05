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
$url32 = 'https://az764295.vo.msecnd.net/stable/f6868fce3eeb16663840eb82123369dec6077a9b/VSCodeSetup-1.12.1.exe'
$url64 = 'https://az764295.vo.msecnd.net/stable/f6868fce3eeb16663840eb82123369dec6077a9b/VSCodeSetup-1.12.1.exe'
$checksum32 = '8357c5cc85bd7cf41392a64d0a1a10bfb7bc576e430f2d05dede455e879a12b6'
$checksum64 = '8357c5cc85bd7cf41392a64d0a1a10bfb7bc576e430f2d05dede455e879a12b6'

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
