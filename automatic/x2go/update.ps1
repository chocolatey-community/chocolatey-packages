Import-Module AU

$releases = 'https://code.x2go.org/releases/binary-win32/x2goclient/releases/'
$softwareName = 'X2Go Client*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*located at\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '^[\d]+\.[\d\.\-]+\/$'
  $verSort = { [version]($_.href -split '[\-\/]' | select -first 1) }
  $releaseUrl = $download_page.Links | ? href -match $re | sort $verSort | select -last 1 -Expand href | % { $releases + $_ }

  $download_page = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing

  $url32 = $download_page.Links | ? href -match "\.exe$" | select -first 1 -expand href | % { $releaseUrl + $_ }

  $verRe = '[-]'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 2
  @{
    URL32 = $url32
    Version = $version32
    ReleaseNotes = "http://wiki.x2go.org/doku.php/doc:release-notes-mswin:x2goclient-${version32}"
  }
}

update -ChecksumFor none
