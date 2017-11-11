import-module au

$releases = 'http://download.nomacs.org/versions'

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
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url     = $download_page.links | ? href -like '*/nomacs-*' | % href | sort -desc | select -First 1
    $version = $url -split '-|\.zip' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL64        = $url
        ReleaseNotes = "https://github.com/nomacs/nomacs/releases/tag/${version}"
        FileName     = $url -split '/' | select -last 1
    }
}

update -ChecksumFor none
