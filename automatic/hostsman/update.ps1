import-module au

$releases = 'http://www.abelhadigital.com/hostsman'

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
    $re    = '(?<!installer)\.zip$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
    @{
        Version      = $url -split '\.zip|_' | select -Index 1
        URL32        = $url
    }
}

update -ChecksumFor none
