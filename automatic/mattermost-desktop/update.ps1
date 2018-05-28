import-module au

$releases = 'https://github.com/mattermost/desktop/releases'

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
    $url32SegmentSize = $([System.Uri]$url32).Segments.Length
    $filename32 = $([System.Uri]$url32).Segments[$url32SegmentSize - 1]

    $url64 = $downloadedPage.links | ? href -match '64.exe$' | select -First 1 -expand href
    $url64SegmentSize = $([System.Uri]$url64).Segments.Length
    $filename64 = $([System.Uri]$url64).Segments[$url64SegmentSize - 1]

    $version = [regex]::match($url32,'/([A-Za-z]+-)+([0-9]+.[0-9]+.[0-9]+).*exe').Groups[2].Value

    # Since upstream is providing hashes, let's rely on these instead.
    # i.e. this adds some added value as we are making sure the hashes are
    # really those computed by upstream. We are not simply relying on the hashs
    # provided by the cmdlet Get-RemoteFiles.
    $hashesText = $downloadedPage.AllElements | Where tagName -eq 'ul' | Where innerText -match '.exe' | Select -First 1 -expand innerText
	$i = 0;
	foreach ($line in $hashesText) {
		if ($line -cmatch $url32) { 
			$hash32Parsed = $hashesText[$i+2] -Split ":";
			$hash32 = $hash32Parsed[1].trim();
		}
		if ($line -cmatch $url64) { 
			$hash64Parsed = $hashesText[$i+2] -Split ":";
			$hash64 = $hash64Parsed[1].trim();
		}
		$i++;
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