import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]fileName32\s*=\s*)('.*')" = "`$1'$($Latest.FileName32)'"
            "(^[$]fileName64\s*=\s*)('.*')" = "`$1'$($Latest.FileName64)'"
        }

        ".\legal\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
     }
}

function global:au_GetLatest {
    $LatestRelease = Get-LatestGitHubRelease git-for-windows git

    # https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/Git-2.11.0-32-bit.exe
    $url32 = $LatestRelease.assets.Where{$_.name -match "Git-.+-32-bit.exe"}.browser_download_url

    # https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/Git-2.11.0-64-bit.exe
    $url64 = $LatestRelease.assets.Where{$_.name -match "Git-.+-64-bit.exe"}.browser_download_url

    $version32 = $url32 -split '-' | Select-Object -Skip 2 -Last 1
    $version64 = $url64 -split '-' | Select-Object -Skip 2 -Last 1
    if ($version32 -ne $version64) {  throw "Different versions for 32-Bit and 64-Bit detected." }

    @{
        Version = $version32
        URL32   = $url32
        URL64   = $url64
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
