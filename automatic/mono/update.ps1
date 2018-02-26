Import-Module AU

$releases = 'https://www.mono-project.com/download/stable/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'" = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*url64(bit)?\s*=\s*)'.*'" = "`${1}'$($Latest.URL64)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)^(\s*checksum64\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum64)'"
      "(?i)^(\s*checksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'mono.*win32[\-\d]+\.msi$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $re = 'mono.*x64[\-\d]+\.msi$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href

  $verRe = '[-]'
  $version32 = $url32 -split "$verRe" | ? { [version]::TryParse($_, [ref]$null) } | select -first 1
  $version64 = $url64 -split "$verRe" | ? { [version]::TryParse($_, [ref]$null) } | select -first 1
  if ($version32 -ne $version64) {
    throw "32bit version do not match the 64bit version"
  }
  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version32
  }
}

update
