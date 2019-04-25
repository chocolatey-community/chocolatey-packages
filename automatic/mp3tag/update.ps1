import-module au

$releases = 'https://community.mp3tag.de/t/mp3tag-development-build-status/455'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
            "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
            "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
        }
        ".\tools\ChocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest "$releases.json" -UseBasicParsing | ConvertFrom-Json

    # We get the id of the first post so we can get json with markdown for that post
    $id = $download_page.post_stream.stream[0]
    $download_page = Invoke-WebRequest "https://community.mp3tag.de/posts/$id.json" -UseBasicParsing | ConvertFrom-Json
    $content = $download_page.raw

    if ($content -notmatch "Version:[\* ]*(\d+\.[\d\.]+)([a-z])?") {
        throw "mp3tag version not found on $releases"
    }

    $version = $Matches[1]
    $versionSuffix = $Matches[2]

    if ($content -notmatch "Status:[\* ]*([a-z]+)") {
        Write-Host "mp3tag status not found on $releases"
        return 'ignore'
    }

    $status = $Matches[1]
    $url32 = 'http://download.mp3tag.de/mp3tagv<version>setup.exe'
    $flatVersion = $version -replace '\.', ''
    $url32 = $url32 -replace '<version>', "$flatVersion$versionSuffix"

    if ($versionSuffix) {
        [char]$letter = $versionSuffix
        [int]$num = $letter - ([char]'a' - 1)
        $version += ".$num"
    }
    if ($status -eq 'Beta') {
        $version += "-beta"
    }
    elseif ($status -ne 'Stable') {
        Write-Host "mp3tag status is not recognizable"
        return 'ignore'
    }

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor none
