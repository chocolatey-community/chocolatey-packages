Import-Module AU

$releases     = 'https://github.com/gobby/gobby/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(download location on\s*)<.*>" = "`${1}<$releases>"
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

  $re = 'gobby\-[0-9\.]+\-x64.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -Last 1 | % { [uri]::new([uri]$releases, $_.href) }

  $verRe = '\/v?'
  $version32 = $url32 -split "$verRe" | select -Last 1 -Skip 1
  @{
    URL32 = $url32
    Version = $version32
  }
}

update -ChecksumFor none
