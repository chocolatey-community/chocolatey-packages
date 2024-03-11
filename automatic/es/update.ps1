Import-Module Chocolatey-AU

$releases = 'https://www.voidtools.com/downloads'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*FileFullPath\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $re            = "ES-[\d\.]+\.zip"
    $urlPath       = $download_page.links | ? href -match $re | Select-Object -First 1 -Expand href
    $version       = ($urlPath -split '-' | Select-Object -Last 1).trim(".zip")
    @{
        Version      = $version
        URL32        = 'https://www.voidtools.com' + $urlPath
        PackageName  = 'es'
    }
}

update -ChecksumFor none
