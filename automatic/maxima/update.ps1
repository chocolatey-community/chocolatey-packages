import-module au

$releases = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows'

function global:au_SearchReplace {
   @{
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = ($download_page.Links | ? href -match "Windows\/" | select -expand href -first 1) -split '\-|\/' | select -last 1 -skip 2

    @{
        Version      = $version
        URL32        = "https://sourceforge.net/projects/maxima/files/Maxima-Windows/${version}-Windows/maxima-clisp-sbcl-${version}-win32.exe"
        URL64        = "https://sourceforge.net/projects/maxima/files/Maxima-Windows/${version}-Windows/maxima-clisp-sbcl-${version}-win64.exe"
        ReleaseNotes = "https://sourceforge.net/p/maxima/code/ci/master/tree/ChangeLog-$($version -replace '\.\d+$').md"
    }
}

update
