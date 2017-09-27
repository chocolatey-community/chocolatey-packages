Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain   = 'https://github.com'
$releases = "$domain/eranif/codelite/releases/latest"

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
  Get-ChildItem "$PSScriptRoot\tools" -Filter "*.7z.7z" | % {
    Move-Item $_.FullName ($_.FullName.Substring(0, $_.FullName.Length - 3)) -Force
  }
  $Latest.FileName32 = $Latest.FileName32 -replace '7z.7z$','7z'
  $Latest.FileName64 = $Latest.FileName64 -replace '7z.7z$','7z'
}
function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'x86.*\.7z$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }

  $re = 'amd64.*\.7z$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }

  $verRe = '\/'
  $version = $url32 -split "$verRe" | select -last 1 -skip 1

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version
    ReleaseNotesUrl = Get-RedirectedUrl $releases
    FileType = '7z'
  }
}

update -ChecksumFor none
