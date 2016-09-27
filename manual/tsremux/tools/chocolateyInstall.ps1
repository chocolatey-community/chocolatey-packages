$packageName = 'tsremux'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$url = 'http://www.videohelp.com/download/TsRemux0.23.2.exe'
$referer = 'http://www.videohelp.com/tools/TsRemux'
$file = "$env:TEMP\TsRemux0.23.2.exe"

wget -P "$env:TEMP" --referer=$referer $url

Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
Remove-Item $file
