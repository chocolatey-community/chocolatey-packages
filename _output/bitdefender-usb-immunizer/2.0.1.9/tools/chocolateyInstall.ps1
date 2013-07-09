$packageName = 'bitdefender-usb-immunizer'
$url = 'http://labs.bitdefender.com/wp-content/updates/immunizer/BDUSBImmunizerLauncher.exe'
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\BDUSBImmunizerLauncher.exe"

try {
    Get-ChocolateyWebFile $packageName $fileFullPath $url
    Install-ChocolateyDesktopLink $fileFullPath
  
    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw 
}