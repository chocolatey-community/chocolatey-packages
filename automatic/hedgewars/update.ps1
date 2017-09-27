Import-Module AU

$domain   = 'https://www.hedgewars.org'
$releases = "$domain/download.html"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
      "(?i)(^\s*fileType\s*=\s*)('.*')" = "`$1'$($Latest.FileType)'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href | % {
      if ($_.StartsWith("/")) { $domain + $_ }
      else { $_ }
    }
    $Matches = $null
    $verRe = '\>\s*Latest Hedgewars Release ([\d]+\.[\d\.]+)\s*\<'
    $download_page.Content -match $verRe | Out-Null
    if ($Matches) { $version = $Matches[1] }
    @{
        Version = $version
        URL32   = $url
    }
}

update -ChecksumFor none
