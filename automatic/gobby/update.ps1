Import-Module AU

$releases     = 'http://releases.0x539.de/gobby/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'gobby\-[0-9\.]+\.exe$'
  $url32 = $releases + ($download_page.Links | ? href -match $re | select -Last 1 -expand href)

  $verRe = '[-]|\.exe'
  $version32 = $url32 -split "$verRe" | select -Last 1 -Skip 1
  @{
    URL32 = $url32
    Version = $version32
  }
}

update -ChecksumFor none
