import-module au

$releases = "https://www.sourcetreeapp.com/enterprise"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    # https://downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_2.5.5.msi
    $re32  = "SourcetreeEnterpriseSetup_(.*).msi"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href

    $version32 = $Matches[1]
    @{
        Version      = $version32
        URL32        = $url32
        PackageName  = 'SourceTree'
        ReleaseNotes = "https://www.sourcetreeapp.com/update/windows/ga/ReleaseNotes_$version32.html"
    }
}

update -NoCheckChocoVersion
