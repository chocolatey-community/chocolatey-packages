Import-Module AU

$releases = 'https://github.com/clsid2/mpc-hc/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
  $releasesPage = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = "tag\/((?:\d+\.){2}\d+)$"

  $versionLink = $releasesPage.Links | Where-Object href -match $re | Select-Object -First 1
  $version = $versionLink.href -split '\/' | Select-Object -Last 1

  $download_page = Invoke-WebRequest -Uri "$($releases)/tag/$($version)" -UseBasicParsing

  $re = 'x64\.exe$'
  $url64 = $download_page.links | Where-Object href -match $re | Select-Object -first 1 -expand href | ForEach-Object { 'https://github.com' + $_ }

  $re = 'x86\.exe$'
  $url32 = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href | ForEach-Object { 'https://github.com' + $_ }

  @{
    URL32   = $url32
    URL64   = $url64
    Version = $version
  }
}

Update-Package -ChecksumFor none
