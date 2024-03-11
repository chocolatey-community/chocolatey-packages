Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(64-Bit.+\<.+/)[\d\.]+/jenkins.msi\>" = "`${1}$($Latest.Version)/jenkins.msi>"
            "(?i)(checksum type:).*"                   = "`${1} $($Latest.ChecksumType64)"
            "(?i)(checksum64:).*"                      = "`${1} $($Latest.Checksum64)"
        }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]ToolsDir\\).+`"" = "`${1}$($Latest.FileName64)`""
        }
    }
}

function global:au_GetLatest {
    $ReleasePage = "https://www.jenkins.io/download/"
    $ReleaseRegex = "Download Jenkins`n(?<Version>[\d\.]+)`nLTS"
    $DownloadURL = "https://get.jenkins.io/windows-stable/"

    if ((Invoke-WebRequest -Uri $ReleasePage -UseBasicParsing).RawContent -match $ReleaseRegex) {
        $LatestVersion = $Matches.Version
        @{
            Version = $LatestVersion
            URL64   = Get-RedirectedUrl "$($DownloadURL.TrimEnd('/'))/$LatestVersion/jenkins.msi"
        }
    } else {
        Write-Error "Could not find a version of Jenkins on '$($ReleasePage)' (with regex '$($ReleaseRegex)')" -ErrorAction Stop
    }
}

update -ChecksumFor none
