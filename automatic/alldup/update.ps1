import-module au

$releases = 'https://www.alldup.info/en_download_alldup.php'


function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $downloadPage = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'AllDupSetup.exe$'
  $url = $downloadPage.links | Where-Object href -match $re | Select-Object -First 1 -expand href
  $downloadPage.links | Where-Object outerHTML -Match 'alldup_version\.php"\>[\d\.]+<' | Select-Object -First 1 | ForEach-Object { $_ -match '\>(?<version>[\d\.]+)<' }

  @{
    URL32 = $url
    Version = $matches.version
  }
}

update -ChecksumFor none
