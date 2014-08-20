$tools="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\sysprogs.cer'"

$packageName = 'wincdemu'
$fileType = 'exe'
$silentArgs = '/UNATTENDED'
$url = 'http://sourceforge.net/projects/wincdemu/files/wincdemu/3.6/WinCDEmu-3.6.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url