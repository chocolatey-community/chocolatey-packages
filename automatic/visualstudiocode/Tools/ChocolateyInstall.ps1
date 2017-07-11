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
$url32 = 'https://az764295.vo.msecnd.net/stable/379d2efb5539b09112c793d3d9a413017d736f89/VSCodeSetup-ia32-1.13.1.exe'
$url64 = 'https://az764295.vo.msecnd.net/stable/379d2efb5539b09112c793d3d9a413017d736f89/VSCodeSetup-ia32-1.13.1.exe'
$checksum32 = '4fe175e35f9cdaf87a93c24d2ba647a617f8758d294fc2050e19248c90ba69e4'
$checksum64 = '4fe175e35f9cdaf87a93c24d2ba647a617f8758d294fc2050e19248c90ba69e4'

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
