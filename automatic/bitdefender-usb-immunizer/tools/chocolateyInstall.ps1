$packageName = 'bitdefender-usb-immunizer'
$url = '{{DownloadUrl}}'
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\BDUSBImmunizerLauncher.exe"

Get-ChocolateyWebFile $packageName $fileFullPath $url
Install-ChocolateyDesktopLink $fileFullPath
