$packageName = 'autohotkey_l.portable'
$url = 'http://l.autohotkey.net/v/AutoHotkey111200.zip'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64 = 'http://l.autohotkey.net/v/AutoHotkey111200_x64.zip'

Install-ChocolateyZipPackage $packageName $url $unzipLocation $url64