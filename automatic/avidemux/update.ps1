import-module au

$releases = 'https://sourceforge.net/projects/avidemux/files/avidemux'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}
function global:au_BeforeUpdate {
    function Convert-ToEmbeded( [switch] $Purge, $Skip = 0 ) {
        if ($Purge) {
            $url = $Latest.URL32; if (!$url) { $url = $Latest.Url64 }
            $file_name = $url -split '/' | select -Last 1 -Skip $Skip
            if ($file_name -match '\.[A-Z]+$') { 
                Write-Host "Purging" $Matches[0]
                rm -Force "$PSScriptRoot\tools\*.$($Matches[0])"
            }
        }

        try {
            $client = New-Object System.Net.WebClient

            if ($Latest.Url32) {
                Write-Host "Downloading" $Latest.Url32
                $file_path = "$PSScriptRoot\tools\" + ($Latest.URL32 -split '/' | select -Last 1 -Skip $Skip)
                $client.DownloadFile($Latest.URL32, $file_path)
                $Latest.Checksum32 = Get-FileHash $file_path | % Hash
            }

            if ($Latest.Url64) {
                Write-Host "Downloading" $Latest.Url64
                $file_path = "$PSScriptRoot\tools\" + ($Latest.URL64 -split '/' | select -Last 1 -Skip $Skip)
                $client.DownloadFile($Latest.URL64, $file_path)
                $Latest.Checksum64 = Get-FileHash $file_path | % Hash
            }
        } finally { $client.Dispose() }
    }

    Convert-ToEmbeded -Purge -Skip 1
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $url =  $download_page.links | ? href -match 'avidemux/[0-9.]+/$' | % href | select -First 1
    $url = 'https://sourceforge.net' + $url

    $version = $url -split '/' | select -Last 1 -Skip 1
    @{
        URL32        = "${url}avidemux_${version}_win32.exe/download"
        URL64        = "${url}avidemux_${version}_win64.exe/download"
        Version      = $version
        ReleaseNotes = "https://sourceforge.net/projects/avidemux/files/avidemux/${version}/"
    }
}

update -ChecksumFor none
