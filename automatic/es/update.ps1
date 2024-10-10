Import-Module Chocolatey-AU

$releases = 'https://www.voidtools.com/downloads'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*FileFullPath\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
            "(?i)(^\s*FileFullPath64\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName64)`""
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page  = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $re             = "ES-[\d\.]+\.x86.zip"
    $urlPath        = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -Expand href
    $re64           = "ES-[\d\.]+\.x64.zip"
    $urlPath64      = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -Expand href
    $version        = ($urlPath -split '-' | Select-Object -Last 1).trim(".x86.zip")
    @{
        Version      = $version
        URL32        = 'https://www.voidtools.com' + $urlPath
        URL64        = 'https://www.voidtools.com' + $urlPath64
        PackageName  = 'es'
    }
}

update -ChecksumFor none