import-module au

$releases = 'https://krita.org/en/download/krita-desktop/'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url64   = $download_page.links | ? href -match 'x64-setup.exe$' | select -First 1 -expand href
    $url32   = $download_page.links | ? href -match 'x86-setup.exe$' | select -First 1 -expand href
    $version64 = $url64 -split '-' | select -First 1 -Skip 1
    $version32 = $url32 -split '-' | select -First 1 -Skip 1

  if ($version32 -ne $version64) {
    throw "32-bit and 64-bit version do not match. Please investigate."
  }

  return @{
        URL32   = $url32
        URL64   = $url64
        Version = $version64
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles  -Purge -NoSuffix }

function global:au_SearchReplace {
   @{
    ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
        "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
        }
    ".\legal\VERIFICATION.txt" = @{
        "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
        "(?i)(x64:).*"        = "`${1} $($Latest.URL64)"
        "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
        "(?i)(type:).*"       = "`${1} $($Latest.ChecksumType32)"
        }
    }
}

update -ChecksumFor none
