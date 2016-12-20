import-module au

$releases = 'http://windows.php.net/download'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = 'php.+\.zip$'
    $url     = $download_page.links | ? href -match 'php-\d.+-nts.+\.zip$'  | % href | select -First 2
    $version = $url[0] -split '-' | select -Index 1
    @{
        Version      = $version
        URL32        = "http://windows.php.net/" + ($url -match 'x86' | select -First 1)
        URL64        = "http://windows.php.net/" + ($url -match 'x64' | select -First 1)
        ReleaseNotes = "https://secure.php.net/ChangeLog-7.php#${version}"
    }
}

update
