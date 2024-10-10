Import-Module Chocolatey-AU


function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
 }

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease -Owner "notepad-plus-plus" -Name "notepad-plus-plus"

    @{
        Version = $LatestRelease.tag_name.Trim("v")
        URL32_i = $LatestRelease.assets | Where-Object {$_.name.EndsWith("Installer.exe")} | Select-Object -ExpandProperty browser_download_url
        URL64_i = $LatestRelease.assets | Where-Object {$_.name.EndsWith("x64.exe")} | Select-Object -ExpandProperty browser_download_url
        URL32_p = $LatestRelease.assets | Where-Object {$_.name.EndsWith("portable.7z")} | Select-Object -ExpandProperty browser_download_url
        URL64_p = $LatestRelease.assets | Where-Object {$_.name.EndsWith("portable.x64.7z")} | Select-Object -ExpandProperty browser_download_url
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
