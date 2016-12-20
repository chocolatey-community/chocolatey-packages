
import-module au

 $releases_x32 = 'https://chromium.woolyss.com/api/v2/?os=windows&bit=32&out=string' # URL to for GetLatest 32bit
 $releases_x64 = 'https://chromium.woolyss.com/api/v2/?os=windows&bit=64&out=string' # URL to for GetLatest 64bit

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]version\s*=\s*)('.*')"= "`$1'$($Latest.Version)'"
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^\s*url64Bit\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $hashtype = 'md5'

    $download_page32 = Invoke-WebRequest -Uri $releases_x32
    $download_page64 = Invoke-WebRequest -Uri $releases_x64

    $val32 = $download_page32 -split ";"
    $val64 = $download_page64 -split ";"

    $chromium32 = $val32 | out-string | ConvertFrom-StringData
    $chromium64 = $val64 | out-string | ConvertFrom-StringData
    $checksum32 = @{$true = $chromium32.checksum_md5; $false = $chromium32.checksum }[ $chromium32.checksum -ne ""]
    $checksum64 = @{$true = $chromium64.checksum_md5; $false = $chromium64.checksum }[ $chromium64.checksum -ne ""]
    $hashtype32 = @{$true = $hashtype; $false = $chromium32.hashtype }[ $chromium32.hashtype -ne ""]
    $hashtype64 = @{$true = $hashtype; $false = $chromium64.hashtype }[ $chromium64.hashtype -ne ""]

    $version = $chromium64.version

    $url32 = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/<revision>/mini_installer.exe'
    $url64 = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/<revision>/mini_installer.exe'
    $url32 = $url32 -replace '<revision>', $chromium32.revision
    $url64 = $url64 -replace '<revision>', $chromium64.revision

    @{
        URL32 = $url32; URL64 = $url64; Version = $version;
        #Diabled until au/issues/36
        #Checksum32     = $checksum32
        #Checksum64     = $checksum64
        ChecksumType32 = $hashtype32
        ChecksumType64 = $hashtype64
    }
}

update
