import-module au

$releases = 'https://github.com/assaultcube/AC/releases'

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
    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = ($url -split '/' | select -last 1 -skip 1).Substring(1)
    @{
        URL32        = 'https://github.com' + $url
        Version      =  $version
        ReleaseNotes = "https://github.com/assaultcube/AC/releases/tag/v${version}"
    }
}

update -ChecksumFor 32
