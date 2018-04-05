Import-Module au

$releases = "https://www.argotronic.com/en/history.php"
$downloads = "https://www.argotronic.com/downloads"
$versionPattern = "([\d]+\.[\d]+\.[\d]+)"
$filePattern = "ArgusMonitor_Setup.exe"

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
    $history_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $history_page.Links | ? href -Match "$($filePattern)$" | % href | Select -First 1 | Out-Null
    $history_page -Match "<a.*>($versionPattern)</a>" | Out-Null
    $version = $Matches[1]

    @{
        Version  = $version
        URL32    = "$downloads/$filePattern"
        FileType = 'exe'
    }
}

update -ChecksumFor none
