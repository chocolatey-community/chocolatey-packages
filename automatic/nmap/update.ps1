import-module au

$releases = 'https://nmap.org/download.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)('.*')"         = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\)(.*`")" = "`$1$($Latest.FileName32)`""
      "(?i)(^\s*fileType\s*=\s*)('.*')"            = "`$1'$($Latest.FileType)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
      "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
    }
  }
}
function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $urls = $download_page.links | ? href -match $re | % href
  foreach ($url in $urls ) {
    $file_name = $url -split '/' | select -Last 1
    if ($file_name -match '(?<=-)[\.0-9]+(?=-)') { $version = $Matches[0]; $url32 = $url; break }
  }
  if (!$version) { throw "Can not find latest version" }

  @{
    URL32        = $url32
    Version      = $version
    ReleaseNotes = "https://nmap.org/changelog.html#${version}"
  }
}

update -ChecksumFor none
