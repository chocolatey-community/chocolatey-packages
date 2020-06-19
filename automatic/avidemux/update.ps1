import-module au

$releases = 'https://sourceforge.net/projects/avidemux/files/avidemux'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"           = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\)[^`"]*" = "`$1$($Latest.FileName64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
            "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
            "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $allReleases = $download_page.links | ? href -Match 'avidemux/[0-9\.]+/$' | % { "https://sourceforge.net" + $_.href }

    foreach ($release in $allReleases) {
      $download_page = Invoke-WebRequest -Uri $release -UseBasicParsing
      $allUrls = $download_page.Links | ? href -match "\.exe\/download$" | select -expand href
      if ($allUrls.Count -ge 1) {
        $url64 = $allUrls | ? { $_ -match "(win64|64Bits.*)\.exe" } | select -first 1
        $version = $release.Split('/') | select -Last 1 -Skip 1
        break
      }
    }


    if ($download_page -match "$version( |\-)(alpha|beta|rc)([^\: ]*)") {
        $version = "$version-$($Matches[2])$($Matches[3])"
    }


    return @{
        URL64        = "$url64"
        Version      = "$version"
        ReleaseNotes = "$release"
        FileType     = 'exe'
    }
}


update -ChecksumFor none

