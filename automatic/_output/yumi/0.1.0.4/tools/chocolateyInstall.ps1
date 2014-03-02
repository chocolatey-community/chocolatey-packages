$packageName = 'yumi'
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\yumi.exe"
$url = 'http://www.pendrivelinux.com/downloads/YUMI/YUMI-0.1.0.4.exe'

Get-ChocolateyWebFile $packageName $fileFullPath $url

Install-ChocolateyDesktopLink $fileFullPath