$installDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'rdcman'
  url            = 'https://download.sysinternals.com/files/RDCMan.zip'
  checksum       = 'fb0d563accc0bc23ce7a9a20e62cc5859c3b3f2fa0f2de3ce7dc23ad9ca2001d'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs

Write-Host 'Creating shortcuts...'
$exePath = Join-Path $installdir 'RDCMan.exe'
$exePathx86 = Join-Path $installdir 'RDCMan-x86.exe'
$startMenu = [System.Environment]::GetFolderPath("CommonStartMenu")
$shortcut = 'Remote Desktop Connection Manager.lnk'
$shortcutx86 = 'Remote Desktop Connection Manager x86.lnk'
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $startMenu "Programs/$shortcut") -TargetPath $exePath
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $startMenu "Programs/$shortcutx86") -TargetPath $exePathx86
