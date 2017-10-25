Import-Module AU

$releases = 'http://bluegriffon.org/'
$softwareName = 'BlueGriffon*'

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
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`$1$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = '\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $version32 = $url32 -split '/' | select -Last 1 -Skip 1
  @{
    URL32 = $url32
    Version = $version32
    ReleaseNotes = "https://github.com/therealglazou/bluegriffon/releases/tag/$version32"
  }
}

update -ChecksumFor none
