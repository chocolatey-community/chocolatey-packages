Import-Module Chocolatey-AU

. "$PSScriptRoot\update_helper.ps1"

$url = 'https://haali.net/winutils/lswitch.exe'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
            "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
            "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_AfterUpdate {
    "$($Latest.ETAG)|$($Latest.Version)" | Out-File "$PSScriptRoot\info" -Encoding utf8
}

function global:au_GetLatest {
    $url32 = $url
    $etag = GetETagIfChanged $url32
    if ($etag) {
        $result = GetResultInformation -url32 $url32 -file 'lswitch.exe'
        $result["ETAG"] = $etag.Headers.ETag
    }
    else {
        $result = @{
            URL32   = $url32
            Version = Get-Content "$PSScriptRoot\info" -Encoding UTF8 | Select-Object -First 1 | ForEach-Object { $_ -split '\|' } | Select-Object -Last 1
        }
    }
    return $result
}

update -NoCheckUrl -ChecksumFor 32