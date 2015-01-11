$packageName = 'adblockplussafari'
$url = 'https://downloads.adblockplus.org/devbuilds/adblockplussafari/00latest.safariextz'
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\00latest.safariextz"

Get-ChocolateyWebFile $packageName $fileFullPath $url

& "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\00latest.safariextz"