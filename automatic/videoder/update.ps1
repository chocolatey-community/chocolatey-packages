import-module au

$domain = 'https://www.videoder.com/download/videoder-for-windows'


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

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
  $download_page_x32 = Invoke-WebRequest -Uri ($domain + '?arch=32') -UseBasicParsing
  $download_page_x64 = Invoke-WebRequest -Uri ($domain + '?arch=64') -UseBasicParsing

  $download_link_x32 = $download_page_x32.links | ? href -match 'Videoder%20Setup%20(\d+\.\d+\.\d+)\.exe'
  $download_link_x64 = $download_page_x64.links | ? href -match 'Videoder%20Setup%20(\d+\.\d+\.\d+)\.exe'
  $version = $Matches[1]

  @{
    URL32   = $download_link_x32.href
    URL64   = $download_link_x64.href
    Version = $version
  }
}

update -ChecksumFor none
