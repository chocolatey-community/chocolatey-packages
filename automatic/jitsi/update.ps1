import-module au

$releases = 'https://download.jitsi.org/jitsi/msi/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = 'jitsi-\d.*'
    $url = $download_page.links | ? href -match $re | ? href -notmatch 'latest' | select -First 2 -expand href
    $url32 = $releases + ($url -match 'x86')
    $url64 = $releases + ($url -match 'x64')

    $version  = $url[0] -split '-' | select -Index 1

    @{ URL64=$url64; URL32 = $url32; Version = $version }
}

update
