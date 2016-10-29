import-module au

$releases = 'https://www.python.org/downloads'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '.exe'
    $url     = $download_page.links | ? href -match $re | select -First 1
    if ($url.InnerText -notmatch 'Download Python (3[\d\.]+)' ) { throw "Python version 3.x not found on $releases" }

    $url32   = $url.href
    $url64   = $url32 -replace '.exe', '-amd64.exe'
    $version = $url32 -split '-|.exe' | select -Last 1 -Skip 1

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced by the virtual package python
    update
}
