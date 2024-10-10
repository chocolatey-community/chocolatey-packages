Import-Module Chocolatey-AU

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease henrypp simplewall

    @{
        Version = $LatestRelease.tag_name.TrimStart("v.")  # Tags have a "v." prefix, not a typo
        URL32_i = $LatestRelease.assets | Where-Object {$_.name.EndsWith(".exe")} | Select-Object -ExpandProperty browser_download_url
        URL32_p = $LatestRelease.assets | Where-Object {$_.name.EndsWith("bin.zip")} | Select-Object -ExpandProperty browser_download_url
    }
}

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
