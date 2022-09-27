Import-Module AU

$releases = "https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/"

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 -Algorithm $Latest.ChecksumType32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64 -Algorithm $Latest.ChecksumType64
}

function Get-EdgePackageVersion {
  param($PackageName = 'microsoft-edge')

  $scrape_content = Invoke-RestMethod -Uri "https://community.chocolatey.org/api/v2/package-versions/$PackageName" -UseBasicParsing

  $scrape_content | Select-Object -Last 1
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"            = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*url64\s*=\s*)'.*'"          = "`${1}'$($Latest.URL64)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"       = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksum64\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'"   = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)^(\s*checksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  # We use the available package on CCR as the source of truth
  $packageVersion = Get-EdgePackageVersion -PackageName 'microsoft-edge'
  $escapedVersion = [regex]::Escape($packageVersion)

  $downloadPage = Invoke-WebRequest $releases -UseBasicParsing

  $url32 = $downloadPage.Links | Where-Object { $_.href -match "$escapedVersion.*win32" } | Select-Object -First 1 -ExpandProperty href
  $url64 = $downloadPage.Links | Where-Object { $_.href -match "$escapedVersion.*win64" } | Select-Object -First 1 -ExpandProperty href

  if (!$url32 -or !$url64) {
    throw "The 32bit or 64bit URL is missing"
  }

  @{
    Version        = $packageVersion
    URL32          = $url32
    URL64          = $url64
    ChecksumType32 = 'sha256'
    ChecksumType64 = 'sha256'
  }
}

Update-Package -ChecksumFor none
