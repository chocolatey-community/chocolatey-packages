import-module au

$releases = 'https://www.tvbrowser.org/index.php?id=windows'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = 'tvbrowser-lite.*\.exe'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
  
  $version  = $url -split '[_]' | select -Last 1 -Skip 1
  if ($version.Length -eq 1) { $version = "$version.0" }

  @{ URL32 = $url; Version = $version; FileType = 'exe' }
}

update -ChecksumFor none
