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

  return "https://download.blender.org/release/Blender$majorVersion/blender-$version-windows-x64.msi"
}

function Get-Checksum() {
  param([string]$version, [string]$majorVersion, [string]$checksumType)

  $checksum_file = Invoke-WebRequest -Uri "https://download.blender.org/release/Blender$majorVersion/blender-$version.$checksumType"

  $re = 'windows-x64\.msi$'
  $checksum = $checksum_file.RawContent -split "\n" -match $re -split " " | Select-Object -First 1

  return $checksum
}

update -ChecksumFor none
