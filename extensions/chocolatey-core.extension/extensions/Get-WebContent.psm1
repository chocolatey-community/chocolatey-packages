
function GetPackageCacheLocation () {
  $chocoTemp      = $env:TEMP
  $packageName    = $env:chocolateyPackageName
  $packageVersion = $env:chocolateyPackageVersion

  $packageTemp = Join-Path $chocoTemp $packageName
  if ($packageVersion) {
    $packageTemp = Join-Path $packageTemp $packageVersion
  }

  $packageTemp
}

function GetTempFileName () {
  $tempDir = GetPackageCacheLocation
  $fileName = [System.IO.Path]::GetRandomFileName()

  $tempFile = Join-Path $tempDir $fileName

  $tempFile
}

function Get-WebContent ([string]$url) {
  $filePath = GetTempFileName
  Get-WebFile -url $url -fileName $filePath

  $fileContent = Get-Content $filePath
  Remove-Item $filePath

  $fileContent
}

Export-ModuleMember -Function Get-WebContent
