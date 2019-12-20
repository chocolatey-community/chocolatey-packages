import-module au

$releases = 'http://www.alldup.de/en_download_alldup.php'


function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re = 'alldup.*\.exe$'
  $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
  $version = $download_page.links | ? href -match "alldup_version\.php$" | select -first 1 -expand innerText

  @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
