Import-Module au

$releases = "https://sourceforge.net/projects/screencloud/files/"
$versionPattern = "([\d]+\.[\d\.]+)"
$filePattern = "ScreenCloud-$($versionPattern)-x86.msi"

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]fileName\s*=\s*)('.*')" = "`${1}'$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"           = "`${1} $($Latest.URL32)"
            "(?i)(checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
            "(?i)(checksum32\:).*"      = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $download_page.Links | ? href -Match "$($versionPattern)/$" | % href | Select -First 1 | Out-Null
    $version = $Matches[1]

    $download_page = Invoke-WebRequest -Uri "$($releases + $version)/windows/" -UseBasicParsing
    $url = $download_page.Links | ? href -Match "$($filePattern)/download" | % href | Select -First 1

    @{
        Version  = $version
        URL32    = $url
        FileType = 'msi'
    }
}

update -ChecksumFor none
