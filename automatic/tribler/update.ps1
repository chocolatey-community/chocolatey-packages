Import-Module AU

$domain = 'https://github.com'
$releases = "$domain/Tribler/tribler/releases/latest"
$softwareName = 'Tribler'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"         = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'x86\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }

  $re = 'x64\.exe$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }

  $verRe = '\/v?'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  $version64 = $url64 -split "$verRe" | select -last 1 -skip 1
  if ($version32 -ne $version64) {
    throw "32bit version do not match the 64bit version"
  }
  @{
    URL32        = $url32
    URL64        = $url64
    Version      = $version32
    ReleaseNotes = Get-RedirectedUrl $releases
  }
}

update -ChecksumFor none
