Import-Module Chocolatey-AU

$releases = 'https://rubyinstaller.org/downloads/archives/'
$fixBelowVersion = '3.1.3'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
      "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
      "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function GetStreams() {
  param($releaseUrls)
  $streams = @{ }

  $re64 = 'x64\.7z$'
  # Temporarily limit the amount of URLs to use until we have at least
  # one approved version. Then slowly increase the limit so we do not
  # overwhelm anything.
  $x64releaseUrls = $releaseUrls | Where-Object href -match $re64 | Select-Object -First 3

  $x64releaseUrls | ForEach-Object {
    $version = $_ -replace '\-([\d]+)', '.$1' -replace 'rubyinstaller.' -replace 'ruby.' -split '/' | Select-Object -Last 1 -Skip 1
    if ($version -match '[a-z]') { Write-Host "Skipping prerelease: '$version'"; return }
    $versionTwoPart = $version -replace '([\d]+\.[\d]+).*', "`$1"

    if ($streams.$versionTwoPart) { return }

    $url64 = $_ | Select-Object -ExpandProperty href
    $url32 = $releaseUrls | Where-Object href -notmatch $re64 | Where-Object href -match $version | Select-Object -ExpandProperty href

    if (!$url32 -or !$url64) {
      Write-Host "Skipping due to missing installer: '$version'"; return
    }

    $fixBelowVersion = switch ($versionTwoPart) {
      '3.1' { '3.1.3' }
      default { '0.0.0' }
    }

    $streams.$versionTwoPart = @{ URL32 = $url32 ; URL64 = $url64 ; Version = Get-FixVersion -Version $version -OnlyFixBelowVersion $fixBelowVersion }
  }

  Write-Host $streams.Count 'streams collected'
  $streams
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.7z$'
  $releaseUrls = $download_page.links | Where-Object href -match $re | Where-Object { $_ -notmatch 'doc' }

  @{ Streams = GetStreams $releaseUrls }
}

update -ChecksumFor none
