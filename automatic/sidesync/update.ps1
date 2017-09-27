import-module au

$releases = 'http://www.samsung.com/global/download/Sidesyncwin'

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

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url = ($download_page.AllElements |  ? tagName -eq 'meta' | % content) -split 'URL=' | select -Last 1
    $url = $url -replace '&amp;', '&'
    $download_page = iwr $url -MaximumRedirection 0 -ea 0 -UseBasicParsing
    $url = $download_page.links.href
    $version  = $url -split '_|.exe' | select -Last 1 -skip 1

    @{
        Version      = $version
        URL32        = $url
        URL64        = $url
    }
}

update
