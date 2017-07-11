import-module au

$releases = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/'

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
    $url = $download_page.links | ? href -match '[\d]+\.[\d\.]+\/$' | % href | select -first 1
    if (!$url.StartsWith("http")) { $url = 'https://sourceforge.net' + $url }
    $version = $url -split '/' | select -Last 1 -Skip 1

    $download_page =  Invoke-WebRequest $url -UseBasicParsing

    $version = $url -split '/' | select -Last 1 -Skip 1
    @{
        URL32    = $download_page.links | ? href -match '\.exe/download$' | % href
        Version  = $version
        FileType = 'exe'
    }
}

update -ChecksumFor 32
