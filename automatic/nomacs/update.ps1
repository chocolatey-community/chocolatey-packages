import-module au

$releases = 'http://download.nomacs.org/versions'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
            "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
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
    $url     = $download_page.links | ? href -like '*/nomacs-*' | % href | sort -desc | select -First 1
    $version = $url -split '-|\.zip' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL64        = 'http://download.nomacs.org/nomacs-setup-x64.msi'
        URL32        = 'http://download.nomacs.org/nomacs-setup-x86.msi'
        ReleaseNotes = "https://github.com/nomacs/nomacs/releases/tag/${version}"
    }
}

update -ChecksumFor none
