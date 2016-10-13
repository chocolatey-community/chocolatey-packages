
import-module au

$releases_x32 = 'https://chromium.woolyss.com/api/?os=windows&bit=32&out=string' # URL to for GetLatest 32bit
$releases_x64 = 'https://chromium.woolyss.com/api/?os=windows&bit=64&out=string' # URL to for GetLatest 64bit

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^\s*url64Bit\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page32 = Invoke-WebRequest -Uri $releases_x32
    $download_page64 = Invoke-WebRequest -Uri $releases_x64

	$val32 = $download_page32 -split ";"
	$val64 = $download_page64 -split ";" 
	
	$chromium32 = $val32 | out-string | ConvertFrom-StringData
	$chromium64 = $val32 | out-string | ConvertFrom-StringData
	
	$version = $chromium64.version
    $url32   = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/<revision>/mini_installer.exe'
    $url64   = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/<revision>/mini_installer.exe'

    $url32   = $url32 -replace '<revision>', $chromium32.revision
    $url64   = $url64 -replace '<revision>', $chromium64.revision

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update
