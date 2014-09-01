$packageName = 'ffmpeg'
$url = 'http://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-2.2.3-win32-shared.7z'
$url64 = 'http://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-2.2.3-win64-shared.7z'

try {
  $destinationFolder = Split-Path $script:MyInvocation.MyCommand.Path

  $binRoot = Get-BinRoot
  $oldDestinationFolders = @(
    (Join-Path $env:SystemDrive 'tools\ffmpeg'),
    (Join-Path $binRoot 'ffmpeg')
  )

  foreach ($oldDestFolder in $oldDestinationFolders) {
    if (Test-Path $oldDestFolder) {

      Write-Output @"
Warning: Deprecated installation folder detected: ${oldDestFolder}.
Please manually remove that folder. This package now installs the ffmpeg binaries to ${scriptDir}\ffmpeg,
which is a better choice.
"@

    }
  }

  Install-ChocolateyZipPackage $packageName $url $destinationFolder $url64

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
