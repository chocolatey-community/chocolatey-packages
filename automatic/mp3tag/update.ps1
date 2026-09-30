Import-Module Chocolatey-AU

$releases = 'https://community.mp3tag.de/t/mp3tag-development-build-status/455'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
            "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
            "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
            "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
        }
        ".\tools\ChocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
            "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest "$releases.json" -UseBasicParsing | ConvertFrom-Json

    # We get the id of the first post so we can get json with markdown for that post
    $id = $download_page.post_stream.stream[0]
    $download_page = Invoke-WebRequest "https://community.mp3tag.de/posts/$id.json" -UseBasicParsing | ConvertFrom-Json
    $content = $download_page.raw

    if ($content -notmatch "Version:[*\s\|]+([\S]+)[\s\|]") {
        throw "mp3tag version not found on $releases"
    }
    $version = $Matches[1]

    if ($content -notmatch "Status:[*\s\|]+([\S]+?)[*\s\|]") {
        Write-Host "mp3tag status not found on $releases"
        return 'ignore'
    }
    $status = $Matches[1]

    if ($status -eq 'Beta') {
        $version += "-beta"
    }
    elseif ($status -ne 'Stable') {
        Write-Host "mp3tag status is not recognizable"
        return 'ignore'
    }

    # Grab the actual download URLs from the markdown links in the post
    $urls = [regex]::Matches($content, 'https://download\.mp3tag\.de/[^\s\)\]]+\.exe') |
        ForEach-Object { $_.Value } |
        Select-Object -Unique

    $url64 = $urls | Where-Object { $_ -match 'x64' } | Select-Object -First 1
    $url32 = $urls | Where-Object { $_ -notmatch 'x64' } | Select-Object -First 1

    if (-not $url32) { throw "mp3tag 32-bit download URL not found on $releases" }
    if (-not $url64) { throw "mp3tag 64-bit download URL not found on $releases" }

    return @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }

}

update -ChecksumFor none