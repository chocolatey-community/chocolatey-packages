Import-Module AU

$releases = 'https://github.com/mumble-voip/mumble/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_AfterUpdate {
  Update-metadata -key "releaseNotes" -value $Latest.ReleaseNotes
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.msi$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { 'https://github.com' + $_ }

  $verRe = '\/'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  @{
    URL32 = $url32
    Version = $version32
    ReleasesUrl = $releases + "/tag/${version32}"
    ReleaseNotes = "https://wiki.mumble.info/wiki/${version32}"
  }
}

update -ChecksumFor none
