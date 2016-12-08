import-module au

$releases = 'https://www.voidtools.com/Changes.txt'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
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
    function Convert-ToEmbeded( [switch] $Purge ) {
        if ($Purge) {
            $url = $Latest.URL32; if (!$url) { $url = $Latest.Url64 }
            $file_name = $url -split '/' | select -Last 1
            if ($file_name -match '\.[A-Z]+$') { rm -Force "$PSScriptRoot\tools\*.$($Matches[0])"}
        }

        try {
            $client = New-Object System.Net.WebClient

            if ($Latest.Url32) {
                $file_path = "$PSScriptRoot\tools\" + ($Latest.URL32 -split '/' | select -Last 1)
                $client.DownloadFile($Latest.URL32, $file_path)
                $Latest.Checksum32 = Get-FileHash $file_path | % Hash
                $Latest.ChecksumType32 = 'sha256'
            }

            if ($Latest.Url64) {
                $file_path = "$PSScriptRoot\tools\" + ($Latest.URL64 -split '/' | select -Last 1)
                $client.DownloadFile($Latest.URL64, $file_path)
                $Latest.Checksum64 = Get-FileHash $file_path | % Hash
                $Latest.ChecksumType64 = 'sha256'
            }
        } finally { $client.Dispose() }
    }

    Convert-ToEmbeded -Purge
    iwr 'https://www.voidtools.com/es.exe' -OutFile $PSScriptRoot\tools\es.exe
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version       = $download_page.Content -split "`n" | sls ': Version .+' | select -First 1
    $version       = $version -split ' ' | select -Last 1
    $choco_version = $version.Replace('b', '') -replace '\.([^.]+)$', '$1'
    @{
        Version      = $choco_version
        URL32        = "https://www.voidtools.com/Everything-${version}.x86-Setup.exe"
        URL64        = "https://www.voidtools.com/Everything-${version}.x64-Setup.exe"
    }
}

update -ChecksumFor none
