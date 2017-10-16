import-module au
import-module "$PSScriptRoot\..\..\extensions\extensions.psm1"

$releases = 'https://www.poweriso.com/download.htm'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $re = 'PowerISO v([\d.]+)'
    $version = ($download_page.Content -split "`n") -match $re | select -first 1
    if ($version -match $re) { $version = $Matches[1] } else { throw "Can't find version" }

    @{
        Version = $version
        Url32   = "http://www.poweriso.com/PowerISO6.exe"
        Url64   = "http://www.poweriso.com/PowerISO6-x64.exe"
    }
}

update
