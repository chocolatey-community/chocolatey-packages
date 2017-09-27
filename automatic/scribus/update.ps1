Import-Module AU

$releases = 'https://sourceforge.net/projects/scribus/files/scribus/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)'.*'"      = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum64)'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\/[\d\.]+\/$'
  $builder = New-Object System.UriBuilder($releases)
  $builder.Path = $download_page.Links | ? href -match $re | select -first 1 -expand href
  $releasesUrl = $builder.Uri.ToString()

  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $re = '\.exe\/download$'
  $urls = $download_page.Links | ? href -match $re | select -expand href

  $url32 = $urls | ? { $_ -notmatch '\-x64' } | select -first 1
  $url64 = $urls | ? { $_ -match '\-x64' } | select -first 1

  $verRe = '\/'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 2

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version32
  }
}

update
