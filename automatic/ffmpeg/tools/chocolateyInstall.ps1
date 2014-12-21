$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'

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
