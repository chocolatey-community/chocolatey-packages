$packageName = 'youtube-dl'
$url = 'https://yt-dl.org/downloads/2014.11.20/youtube-dl.exe'

try {
  $installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $exeDir = "$installDir\youtube-dl.exe"

  Get-ChocolateyWebFile $packageName $exeDir $url

  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
