import-module au

$releases = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
    @{
        URL32 = 'https://github.com' + $url
        URL64 = 'https://github.com' + $url
        Version = ($url -split '/' | select -Last 1 -Skip 1).Replace('v','')
    }
}

update -ChecksumFor 32
