Import-Module AU

$domain = 'https://github.com'
$releases = "$domain/mozilla/geckodriver/releases/latest"

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}
function global:au_GetLatest {
  $releasesUrl = Get-RedirectedUrl $releases

  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

  $url32 = $download_page.Links | ? href -match 'win32\.zip$' | select -First 1 -ExpandProperty href
  $url64 = $download_page.Links | ? href -match 'win64\.zip$' | select -First 1 -ExpandProperty href

  $version32 = $url32 -split '/' | select -last 1 -skip 1 | % { Get-Version $_ }
  $version64 = $url64 -split '/' | select -last 1 -skip 1 | % { Get-Version $_ }

  if ($version32 -ne $version64) {
    throw "Version mismatch between 32bit and 64bit (32bit: $version32, 64bit: $version64)"
  }

  @{
    URL32       = $domain + $url32
    URL64       = $domain + $url64
    Version     = $version32
    ReleasesUrl = $releasesUrl
  }
}

update -ChecksumFor none
