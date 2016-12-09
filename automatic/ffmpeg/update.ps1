import-module au

$releases = 'https://ffmpeg.zeranoe.com/builds'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri "$releases/win32/static/" -UseBasicParsing -Header @{ Referer = $releases }
    $version       = $download_page.links | ? href -match '\.(zip|7z)$' | % { $_.href -split '-' | select -Index 1} | ? { $__=$null; [version]::TryParse($_, [ref] $__) } | sort -desc | select -First 1
    $url32         = "$releases/win32/static/" + ($download_page.links | ? href -like "*$version*" | % href)

    $download_page = Invoke-WebRequest -Uri "$releases/win64/static/" -UseBasicParsing -Header @{ Referer = $releases }
    $url64         = "$releases/win64/static/" + ($download_page.links | ? href -like "*$version*" | % href)

    @{ URL32 = $url32; URL64=$url64; Version = $version }
}

update -NoCheckUrl
