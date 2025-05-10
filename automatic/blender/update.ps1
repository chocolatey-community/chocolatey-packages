Import-Module Chocolatey-AU

$releases = 'https://www.blender.org/download/'
$softwareName = 'Blender'

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-Checksum -version $Latest.Version -majorVersion $Latest.MajorVersion -checksumType $Latest.ChecksumType64
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*url64bit\s*=\s*)'.*'" = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'windows-x64\.msi\/$'
  $url64 = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -Expand href

  $verRe = '-'
  $version64 = $url64 -split "$verRe" | Select-Object -First 1 -Skip 1

  if ($version64 -match '[a-z]$') {
    [char]$letter = $version64[$version64.Length - 1]
    [int]$num = $letter - [char]'a'
    $num++
    $version64 = $version64 -replace $letter,".$num"
  }

  $majorVersion64 = $version64 -split '\.' | Select-Object -First 2
  $majorVersion64 = $majorVersion64 -join '.'

  @{
    URL64 = Get-ActualUrl $version64 $majorVersion64
    ChecksumType64 = "sha256"
    Version = $version64
    MajorVersion = $majorVersion64
  }
}

function Get-ActualUrl() {
  param([string]$version, [string]$majorVersion)

  # Primary URL
  $primaryUrl = "https://download.blender.org/release/Blender$majorVersion/blender-$version-windows-x64.msi"

  # Try the primary URL first
  try {
    $testRequest = Invoke-WebRequest -Uri $primaryUrl -Method Head -UseBasicParsing -ErrorAction SilentlyContinue
    if ($testRequest.StatusCode -eq 200) {
      return $primaryUrl
    }
  }
  catch {
    Write-Host "Primary download URL not available. Trying mirrors..."
  }

  # List of mirrors from the website (https://www.blender.org/about/website/#:~:text=blender.org.-,External%20Mirrors,-With%20over%2018)
  $mirrors = @(
    # USA mirrors
    "https://mirrors.ocf.berkeley.edu/blender/release/Blender$majorVersion/blender-$version-windows-x64.msi",
    # Germany mirror
    "https://ftp.halifax.rwth-aachen.de/blender/release/Blender$majorVersion/blender-$version-windows-x64.msi",
    # Denmark mirror
    "https://mirrors.dotsrc.org/blender/release/Blender$majorVersion/blender-$version-windows-x64.msi",
    # Netherlands
    "https://ftp.nluug.nl/pub/graphics/blender/release/Blender$majorVersion/blender-$version-windows-x64.msi",
    # Asian mirror
    "https://mirror.freedif.org/blender/release/Blender$majorVersion/blender-$version-windows-x64.msi"
  )

  # Try each mirror until one works
  foreach ($mirror in $mirrors) {
    try {
      $testRequest = Invoke-WebRequest -Uri $mirror -Method Head -UseBasicParsing -ErrorAction SilentlyContinue
      if ($testRequest.StatusCode -eq 200) {
        return $mirror
      }
    }
    catch {
      Write-Host "Mirror $mirror not available. Trying next..."
    }
  }

  # If all mirrors fail, return the primary URL as a fallback
  Write-Warning "All download mirrors failed. Returning primary URL as fallback."
  return $primaryUrl
}

function Get-Checksum() {
  param([string]$version, [string]$majorVersion, [string]$checksumType)

  try {
    $checksum_file = Invoke-WebRequest -Uri "https://download.blender.org/release/Blender$majorVersion/blender-$version.$checksumType" -UseBasicParsing -ErrorAction SilentlyContinue

    $re = 'windows-x64\.msi$'
    $checksum = $checksum_file.Content -split "\n" -match $re -split " " | Select-Object -First 1

    if ($checksum) {
      return $checksum
    }
  }
  catch {
    Write-Warning "Failed to get checksum from primary source. Trying mirrors..."
  }

  # Try mirrors for checksum
  $checksumMirrors = @(
    # USA mirrors
    "https://mirrors.ocf.berkeley.edu/blender/release/Blender$majorVersion/blender-$version.$checksumType",
    # Germany mirror
    "https://ftp.halifax.rwth-aachen.de/blender/release/Blender$majorVersion/blender-$version.$checksumType",
    # Denmark mirror
    "https://mirrors.dotsrc.org/blender/release/Blender$majorVersion/blender-$version.$checksumType",
    # Netherlands
    "https://ftp.nluug.nl/pub/graphics/blender/release/Blender$majorVersion/blender-$version.$checksumType",
    # Asian mirror
    "https://mirror.freedif.org/blender/release/Blender$majorVersion/blender-$version.$checksumType"
  )

  foreach ($mirror in $checksumMirrors) {
    try {
      $checksum_file = Invoke-WebRequest -Uri $mirror -UseBasicParsing -ErrorAction SilentlyContinue

      $re = 'windows-x64\.msi$'
      $checksum = $checksum_file.Content -split "\n" -match $re -split " " | Select-Object -First 1

      if ($checksum) {
        return $checksum
      }
    }
    catch {
      Write-Host "Failed to get checksum from mirror $mirror. Trying next..."
    }
  }

  Write-Error "Failed to retrieve checksum from any source. Package update may fail."
  return $null
}

update -ChecksumFor none
