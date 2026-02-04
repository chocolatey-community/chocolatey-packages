$installDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'rdcman'
  url            = 'https://download.sysinternals.com/files/RDCMan.zip'
  checksum       = '32d3e4f4e6db103dbb8a6014f3a0aafda3bbe119d8523090c54833173918e8f4'
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
