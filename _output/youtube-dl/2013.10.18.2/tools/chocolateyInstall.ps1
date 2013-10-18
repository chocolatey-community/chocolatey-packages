$packageName = 'youtube-dl'
$url = 'http://youtube-dl.org/downloads/2013.10.18.2/youtube-dl.exe'

try {
  $installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $exeDir = "$installDir\youtube-dl.exe"

    # Copy 32-bit ffmpeg.exe and ffprobe.exe to tools folder of youtube-dl package
  if (Test-Path "$env:ChocolateyInstall\lib\ffmpeg.2.0.1.20130930\tools\ffmpeg-2.0.1-win32-static\bin") {
    Copy-Item "$env:ChocolateyInstall\lib\ffmpeg.2.0.1.20130930\tools\ffmpeg-2.0.1-win32-static\bin\ffmpeg.exe" "$installDir"
    Copy-Item "$env:ChocolateyInstall\lib\ffmpeg.2.0.1.20130930\tools\ffmpeg-2.0.1-win32-static\bin\ffprobe.exe" "$installDir"
  }

  # Copy 64-bit ffmpeg.exe and ffprobe.exe to tools folder of youtube-dl package
  if (Test-Path "$env:ChocolateyInstall\lib\ffmpeg.2.0.1.20130930\tools\ffmpeg-2.0.1-win64-static\bin") {
    Copy-Item "$env:ChocolateyInstall\lib\ffmpeg.2.0.1.20130930\tools\ffmpeg-2.0.1-win64-static\bin\ffmpeg.exe" "$installDir"
    Copy-Item "$env:ChocolateyInstall\lib\ffmpeg.2.0.1.20130930\tools\ffmpeg-2.0.1-win64-static\bin\ffprobe.exe" "$installDir"
  }

  Get-ChocolateyWebFile $packageName $exeDir $url

  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}