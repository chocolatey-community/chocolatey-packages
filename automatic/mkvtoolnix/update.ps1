import-module au

$domain = 'https://mkvtoolnix.download'
$releases = "$domain/windows/releases"


function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
      "(?i)(\s+x64:).*"     = "`${1} $($Latest.URL64)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $versions = $download_page.links | ? href -match '\/\d+\.[\d\.]+\/' | % { $_.href -split '\/' | select -last 1 -skip 1 }

  $versionSort = { [version]($_.TrimEnd('/')) }
  $version = $versions `
    | sort $versionSort -Descending | select -first 1 | % { $_.TrimEnd('/') }

  $releases = "$releases/$version/"
  $re = 'mkvtoolnix-.+\.exe$'
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url = $download_page.links | ? href -match $re | % href | unique
  $url32 = $url -match '32\-?bit' | select -first 1
  $url64 = $url -match '64\-?bit' | select -first 1

  @{
    URL32   = "$domain" + $url32
    URL64   = "$domain" + $url64
    Version = $version
  }
}

update -ChecksumFor none
