import-module au

$releases = 'https://github.com/keeweb/keeweb/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\legal\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
            "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
        }
    }
}

function global:au_GetLatest {

    $downloadedPage = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $baseUrl = $([System.Uri]$releases).Authority
    $scheme = $([System.Uri]$releases).Scheme

    $url32 = $downloadedPage.links | ? href -match '32.exe$' | select -First 1 -expand href
    if ($url32.Authority -cnotmatch $baseUrl) {
        $url32 = $scheme + '://' + $baseUrl + $url32
    }
    $url32SegmentSize = $([System.Uri]$url32).Segments.Length
    $filename32 = $([System.Uri]$url32).Segments[$url32SegmentSize - 1]

    $url64 = $downloadedPage.links | ? href -match '64.exe$' | select -First 1 -expand href
    if ($url64.Authority -cnotmatch $baseUrl) {
        $url64 = $scheme + '://' + $baseUrl + $url64
    }
    $url64SegmentSize = $([System.Uri]$url64).Segments.Length
    $filename64 = $([System.Uri]$url64).Segments[$url64SegmentSize - 1]

    $version = [regex]::match($url32,'/[A-Za-z]+-([0-9]+.[0-9]+.[0-9]+).*exe').Groups[1].Value

    # Since upstream is providing hashes, let's rely on these instead.
    # i.e. this adds some added value as we are making sure the hashes are
    # really those computed by upstream. We are not simply relying on the hashs
    # provided by the cmdlet Get-RemoteFiles.
    $verifyUrl = $releases + '/download/VERSION/Verify.sha256'
    $verifyUrl = $verifyUrl -Replace 'VERSION',"v$version"
    $downloadedPage = Invoke-WebRequest -Uri $verifyUrl -UseBasicParsing
    $downloadedPage = [System.Text.Encoding]::UTF8.GetString($downloadedPage.Content)
    $downloadedPage = $downloadedPage.Split([Environment]::NewLine)

    foreach ($line in $downloadedPage) {

        $parsed = $line -split ' |\n' -replace '\*',''

        if ($parsed[1] -cmatch $filename32) {
            $hash32 = $parsed[0]
        }
        if ($parsed[1] -cmatch $filename64) {
            $hash64 = $parsed[0]
        }
    }
    return @{
        url32 = $url32;
        url64 = $url64;
        checksum32 = $hash32;
        checksum64 = $hash64;
        checksumType32 = 'SHA256';
        checksumType64 = 'SHA256';
        filename32 = $filename32;
        filename64 = $filename64;
        version = $version;
    }
}

update -ChecksumFor none