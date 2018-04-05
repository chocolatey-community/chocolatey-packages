import-module au

$releases = 'http://hostsman2.it-mate.co.uk/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$(Get-RemoteChecksum $Latest.URL32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $re    = '4[\.\d]+\.zip$'
    $url   = $download_page.links | ? href -match $re | select -Last 1 -expand href | % { $releases + $_ }
    @{
        Version      = $url -split '\.zip|_' | select -Index 1
        URL32        = $url
    }
}

update -ChecksumFor none
