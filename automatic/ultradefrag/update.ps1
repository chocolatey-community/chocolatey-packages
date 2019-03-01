import-module au
import-module "$PSScriptRoot/../../extensions/chocolatey-core.extension/extensions/chocolatey-core.psm1"

$domain   = 'https://sourceforge.net'
$releases = "$domain/projects/ultradefrag/files/stable-release/"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
            "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
            "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
            "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
        }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
            "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $releases_url = $download_page.Links | ? href -match '\d+\.[\d\.]+\/$' | select -expand href -first 1 | % { $domain + $_ }

    $download_page = Invoke-WebRequest -Uri $releases_Url -UseBasicParsing

    $re    = '\.exe\/download$'
    $url   = $download_page.links | ? href -match $re | % href
    $url32 = $url -match 'i386' | select -first 1
    $url64 = $url -match 'amd64' | select -first 1
    if (!$url32.StartsWith("https")) { $url32 = $url32 -replace "^http","https" }
    if (!$url64.StartsWith("https")) { $url64 = $url64 -replace "^http","https" }
    @{
        Version = $url -split '-|\.bin' | select -Last 1 -Skip 1
        URL32   = $url32
        URL64   = $url64
        FileType = 'exe'
    }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = "Unable to connect to the remote server"
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}
