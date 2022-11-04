import-module au

$releases = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"      = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*"  = "`${1} $($Latest.Checksum32)"
        }
     }
 }

 function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $latestrelease = Get-GitHubRelease -Owner "Klocman" -Name "Bulk-Crap-Uninstaller"
    $re      = '\.exe$'
    $url     = $latestrelease.assets.browser_download_url | Where-Object { $_ -match $re } | select -First 1
    $version = ($url -split '/' | select -Last 1 -Skip 1).Replace('v','')
    @{
        URL32        = $url
        Version      = $version
        ReleaseNotes = "https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/tag/v${version}"
    }
}

update -ChecksumFor none
