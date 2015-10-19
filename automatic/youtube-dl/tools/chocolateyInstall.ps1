$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'

$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeDir = "$installDir\youtube-dl.exe"

Get-ChocolateyWebFile $packageName $exeDir $url
