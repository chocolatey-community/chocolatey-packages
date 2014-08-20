$packageName = 'autohotkey.portable'
$url = 'http://ahkscript.org/download/1.1/AutoHotkey111504.zip'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64 = 'http://ahkscript.org/download/1.1/AutoHotkey111504_x64.zip'

Install-ChocolateyZipPackage $packageName $url $unzipLocation $url64