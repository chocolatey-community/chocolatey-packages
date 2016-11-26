import-module au

$releases = 'http://download.gna.org/hedgewars'

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
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | % href
    $version = $url | % { ($_ -split '\.exe|-' | select -Index 1) } | ? { [version]::TryParse($_,[ref]($__))} | measure -max | % maximum
    @{
        Version = $version
        URL32   = "http://download.gna.org/hedgewars/Hedgewars-${version}.exe"
        URL64   = "http://download.gna.org/hedgewars/Hedgewars-${version}.exe"
    }
}

update -ChecksumFor 32
