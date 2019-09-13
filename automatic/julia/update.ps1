import-module au

$releases = 'https://julialang.org/downloads/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`$1$($Latest.FileName32)`""
            "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`$1$($Latest.FileName64)`""
            "(?i)(^[$]packageVersion\s*=\s*).*"        = "`$1`"$($Latest.VersionReal)`""
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(32-bit installer:\s+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-bit installer:\s+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*"        = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:\s+).*"           = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*"           = "`${1}$($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {


    $download_page = Invoke-WebRequest -Uri "$releases" -UseBasicParsing
    $url32 = $download_page.links | ? href -match '/julia-(.+)-win32\.exe$' | % href | select -First 1
    $url64 = $download_page.links | ? href -match '/julia-(.+)-win64\.exe$' | % href | select -First 1

    $version = $Matches[1]

    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
        VersionReal = $version
        ReleaseNotes = "https://github.com/JuliaLang/julia/releases/tag/v${version}"
    }
}

update -ChecksumFor none
