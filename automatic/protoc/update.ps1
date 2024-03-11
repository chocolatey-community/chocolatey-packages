Import-Module Chocolatey-AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*FileFullPath\s*=\s*`"[$]toolsPath\\).*"   = "`$1$($Latest.FileName32)`""
            "(?i)(^\s*FileFullPath64\s*=\s*`"[$]toolsPath\\).*" = "`$1$($Latest.FileName64)`""
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(32-bit zip file:\s+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-bit zip file:\s+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*"       = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:\s+).*"          = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*"          = "`${1}$($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease protocolbuffers protobuf

    @{
        URL32   = $LatestRelease.assets | Where-Object {$_.name -match 'protoc-(?<Version>(\d+\.?){2,3})-win32\.zip$'} | Select-Object -ExpandProperty browser_download_url
        URL64   = $LatestRelease.assets | Where-Object {$_.name -match 'protoc-(?<Version>(\d+\.?){2,3})-win64\.zip$'} | Select-Object -ExpandProperty browser_download_url
        Version = $LatestRelease.tag_name.TrimStart("v")
        ReleaseNotes = $LatestRelease.html_url
    }
}

update -ChecksumFor none
