import-module au

$releases = 'https://github.com/ckaiser/Lightscreen/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32  = $download_page.links | ? href -match '.exe$' | select -First 1 -expand href
  $version   = $url32 -split '-|.exe' | select -Last 1 -Skip 1

  return @{
    URL32    = 'https://github.com' + $url32
    Version  = $version
  }
}

function global:au_SearchReplace {
   @{
    ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
        }
    ".\legal\VERIFICATION.txt" = @{
        "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
        "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        "(?i)(type:).*"       = "`${1} $($Latest.ChecksumType32)"
        }
  }
}

update -ChecksumFor none
