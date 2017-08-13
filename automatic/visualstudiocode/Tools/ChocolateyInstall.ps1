$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'

if (Get-32BitInstalledOn64BitSystem -product $softwareName) {
  Write-Output $(
    'Detected the 32-bit version of Visual Studio Code on a 64-bit system. ' +
    'This package will continue to install the 32-bit version of Visual Studio Code ' +
    'unless the 32-bit version is uninstalled.'
  )
}

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
$url32 = 'https://az764295.vo.msecnd.net/stable/8b95971d8cccd3afd86b35d4a0e098c189294ff2/VSCodeSetup-ia32-1.15.0.exe'
$url64 = 'https://az764295.vo.msecnd.net/stable/8b95971d8cccd3afd86b35d4a0e098c189294ff2/VSCodeSetup-x64-1.15.0.exe'
$checksum32 = '9ee938c5f695fd54a06f9a48122d409f5a12d2039f63741c82d58314f1da89d6'
$checksum64 = '0c77cdb1c472a4dcbedc39d704ad79248997a66450083f3a1e48dd070b37f439'

$packageArgs = @{
  packageName = $packageName
  fileType = 'EXE'
  url = $url32

  softwareName = $softwareName

  checksum = $checksum32
  checksumType = 'sha256'

  silentArgs = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

if (!(Get-32BitInstalledOn64BitSystem($softwareName)) -and (Get-ProcessorBits 64)) {
  $packageArgs.Checksum64 = $checksum64
  $packageArgs.ChecksumType64 = 'sha256'
  $packageArgs.Url64 = $url64
}

Install-ChocolateyPackage @packageArgs
