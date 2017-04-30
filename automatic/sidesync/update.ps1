import-module au
import-module $PSScriptRoot\..\..\scripts\au_extensions.psm1

$releases = 'http://www.samsung.com/us/sidesync'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re   = '\.exe$'
    $url  = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url  = "https://www.samsung.com/$url"
    $version  = $url -split '_|.exe' | select -Last 1 -skip 1

    @{
        Version      = $version
        URL32        = $url
        URL64        = $url
    }
}

update
