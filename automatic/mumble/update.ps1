import-module au

$releases = 'https://github.com/mumble-voip/mumble/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url = $download_page.links | ? href -match $re | % href | select -first 1

    $re    = '\.msi$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = $url -split '-|\.msi' | select -last 1 -skip 1

    @{
        Version      = $version
        URL32        = 'https://github.com' + $url
        ReleaseNotes = "https://github.com/mumble-voip/mumble/releases/tag/${version}"
    }
}

update
