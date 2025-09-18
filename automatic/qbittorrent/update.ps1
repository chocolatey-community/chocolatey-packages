Import-Module Chocolatey-AU

$domain   = 'https://sourceforge.net'
$releases = "$domain/projects/qbittorrent/files/qbittorrent-win32/"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameSkip 1 -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\verification.txt" = @{
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re    = 'qbittorrent-(?<version>[\d\.]+)\/'
  $releasesUrl  = $download_page.links | Where-Object href -Match $re | Select-Object -First 1 -ExpandProperty href | ForEach-Object { $domain + $_ }
  $version = $Matches['version']

  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $re = 'x64_setup.*\.exe\/download$'
  $url64 = $download_page.links | Where-Object href -Match $re | Select-Object -First 1 -ExpandProperty href

  return @{
    URL64    = $url64
    Version  = $version
    FileType = 'exe'
  }
}

update -ChecksumFor none
