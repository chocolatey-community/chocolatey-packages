$tools="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\sysprogs.cer'"

$packageName = 'wincdemu'
$fileType = 'exe'
$silentArgs = '/UNATTENDED'
$url = 'http://wincdemu.sysprogs.org/download/WinCDEmu-3.6.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url