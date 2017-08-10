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
$url32 = 'https://az764295.vo.msecnd.net/stable/8b95971d8cccd3afd86b35d4a0e098c189294ff2/VSCodeSetup-ia32-1.15.0.exe'
$url64 = 'https://az764295.vo.msecnd.net/stable/8b95971d8cccd3afd86b35d4a0e098c189294ff2/VSCodeSetup-x64-1.15.0.exe'
$checksum32 = '9ee938c5f695fd54a06f9a48122d409f5a12d2039f63741c82d58314f1da89d6'
$checksum64 = '0c77cdb1c472a4dcbedc39d704ad79248997a66450083f3a1e48dd070b37f439'

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
