import-module au

$releases = 'https://www.smartftp.com/download'

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
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url = $download_page.links | ? href -match $re

    $url   = $url | ? OuterHTML -match '64-bit' | select -First 1
    $version = $url.OuterHTML -split ' ' | ? {  [version]::TryParse($_, [ref]($__)) }
    @{
        Version      = $version
        URL32        = 'https://www.smartftp.com/get/SmartFTP86.msi'
        URL64        = 'https://www.smartftp.com/get/SmartFTP64.msi'
    }
}

update
