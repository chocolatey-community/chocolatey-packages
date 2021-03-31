Import-Module AU

$releases = "https://downloads.codelite.org/"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -FileNameBase "codelite"
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'windows$'
  $re64 = 'windows_64$'
  $url = $download_page.links | ? href -match $re | select -First 1 -Expand href | % { Get-RedirectedUrl $_  3>$null }
  $url64 = $download_page.links | ? href -match $re64 | select -First 1 -Expand href { % Get-RedirectedUrl $_  3>$null }
  $version = $download_page.content -match "CodeLite ([\d\.]+) - Stable Release" | select -first 1 | % { $Matches[1] }

  @{
    URL64        = $url64
    URL32        = $url
    Version      = $version
    ReleaseNotes = "https://github.com/eranif/codelite/releases/tag/$version"
    FileType     = "exe"
  }
}

update -ChecksumFor none
