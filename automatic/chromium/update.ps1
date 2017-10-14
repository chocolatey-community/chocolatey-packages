import-module au

$releases = 'https://github.com/henrypp/chromium/releases/latest'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^\s*url64Bit\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_BeforeUpdate {
	$Latest.ChecksumType32 = 'sha256'
	$Latest.ChecksumType64 = 'sha256'
	$Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.URL32 -Algorithm $Latest.ChecksumType32
	$Latest.Checksum64 = Get-RemoteChecksum -Url $Latest.URL64 -Algorithm $Latest.ChecksumType64
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	$url32 = "https://github.com" + ($download_page -replace "tag","download" -replace "win64","win32") + "/chromium-sync.exe"
	$url64 = "https://github.com" + ($download_page -replace "tag","download" -replace "win32","win64") + "/chromium-sync.exe"

	return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

Update-Package -ChecksumFor none
