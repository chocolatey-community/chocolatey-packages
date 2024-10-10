Import-Module Chocolatey-AU

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]fileName\s*=\s*)('.*')"  = "`$1'$($Latest.FileName)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"        = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
    $latestRelease = Get-GitHubRelease -Owner nomacs -Name nomacs
    $url     = $latestRelease.assets.Where{$_.name -like 'nomacs-*.zip'}[0].browser_download_url
    $version = $latestRelease.tag_name.TrimStart('v')
    @{
        Version      = $version
        URL64        = $url
        ReleaseNotes = $latestRelease.html_url
        FileName     = $url -split '/' | Select-Object -last 1
    }
}

update -ChecksumFor none
