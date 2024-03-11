Import-Module Chocolatey-AU

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    # We use this method because the nightly builds are published without prerelease
    $ReleaseRequest = @{
        Uri = "https://api.github.com/repos/msys2/msys2-installer/releases"
    }

    if (-not [string]::IsNullOrEmpty($env:github_api_key)) {
        $ReleaseRequest.Headers = @{
            Authorization = "Bearer $($env:github_api_key)"
        }
    }

    $LatestRelease = (Invoke-RestMethod @ReleaseRequest  |
        Where-Object {$_.tag_name -notmatch "^nightly"} |
        Sort-Object published_at)[0]

    @{
        URL64        = $LatestRelease.assets | Where-Object {
            $_.name -match '^msys2-base-x86_64-(?<Version>\d+)\.tar\.xz$'
        } | Select-Object -ExpandProperty browser_download_url
        Version      = "$($Matches.Version).0.0"
    }
}

update -ChecksumFor none
