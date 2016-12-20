import-module au

$releases = 'https://github.com/jetwhiz/encfs4win/releases'

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

    $re      = '\.exe$'
    $url     = $download_page.links | ? href -match $re | select -First 2 -expand href
    $url32   = $url -notmatch 'legacy'
    $version = ($url32 -split '/' | select -Last 1 -Skip 1).Substring(1)
    @{
        Version      = $version
        URL32        = 'https://github.com' + $url32
        ReleaseNotes = "https://github.com/jetwhiz/encfs4win/releases/tag/v${version}"
    }
}

update -ChecksumFor 32
