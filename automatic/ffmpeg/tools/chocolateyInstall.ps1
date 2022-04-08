$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  FileFullPath64 = "$toolsPath\ffmpeg-release-essentials.7z"
  Destination    = $toolsPath
}

Get-ChildItem $toolsPath\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs

Write-Host "Removing extracted archive."
Remove-Item $packageArgs['FileFullPath64'] -ea 0

$maxTries = 3

for ($tries = 0; $tries -lt $maxTries; $tries++) {
  Write-Host "Sleeping for 2 seconds to allow anti-viruses to finish scanning..."
  Start-Sleep -Seconds 2
  try {
    Write-Host "Renaming ffmpeg directory to common name (Try $($tries + 1) / $maxTries)"
    Move-Item $toolsPath\ffmpeg-* $toolsPath\ffmpeg
    Write-Host "Successfully renamed directory."
    break
  }
  catch {
    if (($tries + 1) -eq $maxTries) {
      throw "Unable to rename directory, and max tries achieved. Aborting installation..."
    }
    else {
      Write-Warning "Unable to rename directory. Retrying..."
    }
  }
}
