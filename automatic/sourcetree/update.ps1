import-module au

$releases = 'https://www.sourcetreeapp.com'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    # https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-1.10.23.1.exe
    $re32  = "SourceTreeSetup-(.*).exe"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href

    @{
        Version     = $Matches[1]
        URL32       = $url32
        PackageName = 'SourceTree'
    }
}

update
