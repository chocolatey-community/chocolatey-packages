$installDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'rdcman'
  url            = 'https://download.sysinternals.com/files/RDCMan.zip'
  checksum       = 'eb6cbbf57e164df50027d5589c415be2a5a6df965d1c3861e04dd6a146f80dc1'
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
