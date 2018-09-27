import-module au

$releases = 'https://github.com/poooi/poi/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`$1$($Latest.FileName32)`""
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(1\..+)\<.*\>"         = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum:\s+).*"      = "`${1}$($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {

    $stableReleaseFound = $false
    $url = ''
    $lastVersionString = ''
    do {
        $download_page = Invoke-WebRequest -Uri "$releases$lastVersionString" -UseBasicParsing
        $urls = $download_page.links | ? href -match 'poi-setup-.+\.exe$' | % href
        $stableUrls = @($urls) -match 'poi-setup-\d+\.\d+\.\d+\.exe$'
        if($stableUrls.Count -gt 0) {
            $url = $stableUrls | select -First 1
            $stableReleaseFound = $true
        }
        else {
            $lastUrl = $urls | select -Last 1
            $lastVersionString = "?after=$(Split-Path(Split-Path($lastUrl)) -Leaf)"
        }
    }
    until($stableReleaseFound)

    $license = (Invoke-WebRequest -Uri "https://cdn.rawgit.com/poooi/poi/master/LICENSE" -UseBasicParsing).Content
    Set-Content -Value $license -Path ".\legal\LICENSE.txt"

    $exeSep  = (Split-Path($url) -Leaf) -split '-|\.exe'
    $version = $exeSep | select -Last 1 -Skip 1

    @{
        URL32   = 'https://github.com' + $url
        Version = $version
        ReleaseNotes = "$releases/tag/v${version}"
        License = $license
    }
}

update -ChecksumFor none
