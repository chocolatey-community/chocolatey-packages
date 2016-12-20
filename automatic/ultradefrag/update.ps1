import-module au
import-module "$PSScriptRoot/../../extensions/chocolatey-core.extension/extensions/chocolatey-core.psm1"


$releases = 'http://ultradefrag.sourceforge.net/en/index.html?download'

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

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | % href
    $url32 = $url -match 'i386' | select -first 1
    $url64 = $url -match 'amd64' | select -first 1
    if (!$url32.StartsWith("https")) { $url32 = $url32 -replace "^http","https" }
    if (!$url64.StartsWith("https")) { $url64 = $url64 -replace "^http","https" }
    @{
        Version = $url -split '-|\.bin' | select -Last 1 -Skip 1
        URL32   = $url32
        URL64   = $url64
    }
}

try {
    update
} catch {
    $ignore = "Unable to connect to the remote server"
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}
