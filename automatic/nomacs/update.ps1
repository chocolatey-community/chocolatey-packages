Import-Module Chocolatey-AU

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
            "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
    $latestRelease = Get-GitHubRelease -Owner nomacs -Name nomacs
    $url     = $latestRelease.assets.Where{$_.name -like 'nomacs-*x64.msi'}[0].browser_download_url
    $version = $latestRelease.tag_name.TrimStart('v')
    @{
        Version      = $version
        URL64        = $url
        ReleaseNotes = $latestRelease.html_url
    }
}

update -ChecksumFor none
