import-module au
import-module "../../extensions/extensions.psm1"

$releases = 'https://support.apple.com/kb/DL837?locale=en_US'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*-Url\s+)('.*')"            = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*-Checksum\s+)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*-ChecksumType\s+)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $re = 'https:\/\/secure-appldnld\.apple\.com\/QuickTime\/[a-zA-Z\d\-\.]+\/QuickTimeInstaller\.exe'
    $download_page.content -match $re | Out-Null
    $url = $Matches[0]

    $re = 'strTitle"\s*:\s*"[^\d\.]+([\d\.]+)[^"]+'
    $download_page.content -match $re | Out-Null
    $version = $Matches[1]
    @{
        URL32   = $url
        Version = $version
        PackageName = 'Quicktime'
    }
}

try {
    update -ChecksumFor 32
} catch {
    if ($_ -match 'Access Denied') { Write-Host 'Access Denied error'; 'ignore' }  else { throw $_ }
}
