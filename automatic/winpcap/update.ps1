import-module au
import-module $PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1

$releases = 'https://www.winpcap.org/install/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
            "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
            "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
        }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.exe$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url  -split 'WinPcap_|\.exe' | select -Last 1 -Skip 1
    @{
        Version      = $version.Replace('_', '.')
        URL32        = $releases + $url
        PackageName  = 'WinPcap'
    }
}

update -ChecksumFor None
