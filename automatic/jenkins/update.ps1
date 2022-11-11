#requires -Modules au, Wormies-AU-Helpers
param(
    # The URL to search for information on the latest release
    $ReleasePage = "https://www.jenkins.io/download/",

    # The regex used to search for the latest version on the ReleasePage
    $ReleaseRegex = "Download Jenkins`n(?<Version>[\d\.]+)`nLTS",

    # The base of the download URL
    $DownloadURL = "https://mirrors.jenkins-ci.org/windows-stable/"
)

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
    @{}
}

function global:au_GetLatest {
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

if ($MyInvocation.InvocationName -ne '.') {
    # run the update only if script is not sourced
    update -ChecksumFor none
}