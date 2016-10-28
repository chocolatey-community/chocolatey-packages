import-module au

$releases = 'https://www.blender.org/download/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.msi$'
    $urls = $download_page.Links | ? href -match $re | select -expand href
    $url32 = $urls -match "windows32" | select -first 1
    $url64 = $urls -match "windows64" | select -first 1

    $version  = $url32 -split '[a-f]?-' | select -Last 1 -Skip 1

    return @{
      URL32 = $url32
      URL64 = $url64
      Version = $version
    }
}

update
