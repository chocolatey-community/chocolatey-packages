import-module au

$releases = 'https://sourceforge.net/projects/avidemux/files/avidemux'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"           = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\)[^`"]*"   = "`$1$($Latest.FileName32)"
            "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\)[^`"]*" = "`$1$($Latest.FileName64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
            "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
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
      if ($allUrls.Count -ge 2) {
        break
      }
    }

    $url32 = $allUrls | ? { $_ -match "win32?\.exe" } | select -first 1
    $url64 = $allUrls | ? { $_ -match "(win64|64Bits.*)\.exe" } | select -first 1


    $version = $release -split '/' | select -Last 1 -Skip 1

    if ($download_page -match "$version( |\-)(alpha|beta|rc)([^\: ]*)") {
        $version = "$version-$($Matches[2])$($Matches[3])"
    }


    return @{
        URL32        = "$url32"
        URL64        = "$url64"
        Version      = $version
        ReleaseNotes = "$release"
        FileType     = 'exe'
    }
}


update -ChecksumFor none

