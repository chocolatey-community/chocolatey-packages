Import-Module Chocolatey-AU

$domain = 'https://mkvtoolnix.download'
$releases = "$domain/windows/releases"


function global:au_SearchReplace {
  @{
    '.\legal\VERIFICATION.txt'      = @{
      '(?i)(\s+x32:).*'     = "`${1} $($Latest.URL32)"
      '(?i)(\s+x64:).*'     = "`${1} $($Latest.URL64)"
      '(?i)(checksum32:).*' = "`${1} $($Latest.Checksum32)"
      '(?i)(checksum64:).*' = "`${1} $($Latest.Checksum64)"

    }
    '.\tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $versions = $download_page.links | Where-Object href -Match '\/\d+\.[\d\.]+\/' | ForEach-Object { $_.href -split '\/' | Select-Object -Last 1 -Skip 1 }

  $versionSort = { [version]($_.TrimEnd('/')) }
  $version = $versions `
  | Sort-Object $versionSort -Descending | Select-Object -First 1 | ForEach-Object { $_.TrimEnd('/') }

  $releases = "$releases/$version/"
  $re = 'mkvtoolnix-.+\.exe$'
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url = $download_page.links | Where-Object href -Match $re | ForEach-Object href | Get-Unique
  $url32 = $url -match '32\-?bit' | Select-Object -First 1
  $url64 = $url -match '64\-?bit' | Select-Object -First 1

  @{
    URL32   = "$domain" + $url32
    URL64   = "$domain" + $url64
    Version = $version
  }
}

update -ChecksumFor none
