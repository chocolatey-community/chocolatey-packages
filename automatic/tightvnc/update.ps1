import-module au

$releases = 'http://www.tightvnc.com/download.php'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<projectSourceUrl\>).*?(\</projectSourceUrl\>)" = "`${1}$($Latest.ProjectSourceUrl)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $re    = '\.msi$'
    $url   = $download_page.links | ? href -match $re | % href
    @{
        Version      = $url[0] -split '-' | select -Index 1
        URL32        = $url -match '32bit' | select -First 1
        URL64        = $url -match '64bit' | select -First 1
        ProjectSourceUrl  = $download_page.links | ? href -match 'tightvnc-.+src' | % href
    }
}

update
