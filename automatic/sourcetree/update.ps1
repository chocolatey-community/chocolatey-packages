import-module au
 . ".\update_helper.ps1"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
     }
}

function global:au_GetLatest {
  return Get-JavaSiteUpdates -Package "sourcetree" -Title "Sourcetree for Windows Enterprise"
}

update
