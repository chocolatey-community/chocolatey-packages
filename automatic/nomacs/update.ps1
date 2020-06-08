import-module au

$releases = 'https://github.com/nomacs/nomacs/releases'

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

function global:au_BeforeUpdate  { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url     = $download_page.links | ? href -like '*/nomacs-*x64.msi' | % href | select -First 1
    $version = $url -split '\/' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL64        = "https://github.com/${url}"
        ReleaseNotes = "https://github.com/nomacs/nomacs/releases/tag/${version}"
    }
}

update -ChecksumFor none
