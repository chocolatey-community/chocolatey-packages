Import-Module Chocolatey-AU

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(<releaseNotes>)(.*)(<\/releaseNotes>)" = "`$1$($Latest.ReleaseUrl)`$3"
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease github git-lfs

    #git-lfs-windows-1.4.4.exe
    $LatestAsset = $LatestRelease.assets | Where-Object {$_.name -match "git-lfs-windows-(?<Version>.+).exe"}

    @{
        URL32 = $LatestAsset.browser_download_url
        Version = $LatestRelease.tag_name.TrimStart("v")
        FileName = $LatestAsset.name
        ReleaseUrl = $LatestRelease.html_url
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
