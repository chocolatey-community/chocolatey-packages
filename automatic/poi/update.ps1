Import-Module Chocolatey-AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`$1$($Latest.FileName32)`""
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(1\..+)\<.*\>"         = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum:\s+).*"      = "`${1}$($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease poooi poi

    @{
        URL32   = $LatestRelease.assets | Where-Object {$_.name -match '^poi-setup-(?<Version>.+)\.exe$'} | Select-Object -ExpandProperty browser_download_url
        Version = $LatestRelease.tag_name.TrimStart("v") -replace "beta\.", "beta"
        ReleaseNotes = $LatestRelease.html_url
    }
}

update -ChecksumFor none
