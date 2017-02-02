$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'bitdefender-usb-immunizer'
  fileFullPath   = "$toolsPath\BDUSBImmunizerLauncher.exe"
  url            = 'https://labs.bitdefender.com/wp-content/plugins/download-monitor/download.php?id=BDUSBImmunizerLauncher.exe'
  checksum       = '47AC96402869B71BF2CBFFC5A72F6251289C59350F7227B5DDAE7039993E8361'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$fileName = [System.IO.Path]::GetFileNameWithoutExtension($packageArgs.fileFullPath)

Install-ChocolateyShortcut `
  -ShortcutFilePath "$desktop\$fileName.lnk" `
  -TargetPath $packageArgs.fileFullPath
