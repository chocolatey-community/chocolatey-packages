import-module au

$releases = 'https://www.zotero.org/download'

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
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version  = $url -split '/' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = $url
    }
}

update -ChecksumFor 32
