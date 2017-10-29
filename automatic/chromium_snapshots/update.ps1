
import-module au
. "$PSScriptRoot\update_helper.ps1"


function global:au_BeforeUpdate {
  # Copy the original file from the chromium folder
    Get-RemoteFiles -Purge -FileNameBase "$($Latest.PackageName)"
}

function global:au_SearchReplace {
   @{
    ".\legal\verification.txt" = @{
        "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
        "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
        "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
        "(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
        "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
        }
    ".\tools\chocolateyInstall.ps1" = @{
        "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        '(?i)(^\s*file\s*=\s*)(".*")' = "`$1""$($Latest.PackageName32)"""
        '(?i)(^\s*file64\s*=\s*)(".*")' = "`$1""$($Latest.PackageName64)"""
        }
    }
}

function global:au_GetLatest {
 $releases_x32 = 'https://chromium.woolyss.com/api/v2/?os=windows&bit=32&out=string' # URL to for GetLatest 32bit
 $releases_x64 = 'https://chromium.woolyss.com/api/v2/?os=windows&bit=64&out=string' # URL to for GetLatest 64bit
    $hashtype = 'md5'

    $download_page32 = Invoke-WebRequest -Uri $releases_x32
    $download_page64 = Invoke-WebRequest -Uri $releases_x64

    $val32 = $download_page32 -split ";"
    $val64 = $download_page64 -split ";"

    $chromium32 = $val32 | out-string | ConvertFrom-StringData
    $chromium64 = $val64 | out-string | ConvertFrom-StringData
    # $checksum32 = @{$true = $chromium32.checksum_md5; $false = $chromium32.checksum }[ $chromium32.checksum -eq ""]
    # $checksum64 = @{$true = $chromium64.checksum_md5; $false = $chromium64.checksum }[ $chromium64.checksum -eq ""]
    # $hashtype32 = @{$true = $hashtype; $false = $chromium32.hashtype }[ $chromium32.hashtype -ne ""]
    # $hashtype64 = @{$true = $hashtype; $false = $chromium64.hashtype }[ $chromium64.hashtype -ne ""]
    $ChecksumType = 'sha256'

    $version = $chromium32.version + "-snapshots"
    $Latest.PackageName = 'chromium'
    $Latest

    $url32 = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/<revision>/mini_installer.exe'
    $url64 = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/<revision>/mini_installer.exe'
    $url32 = $url32 -replace '<revision>', $chromium32.revision
    $url64 = $url64 -replace '<revision>', $chromium64.revision
    $PackageName32 = ("`$toolsdir\"+($Latest.PackageName)+"_x32.exe");
    $PackageName64 = ("`$toolsdir\"+($Latest.PackageName)+"_x64.exe");
    
    @{
        URL32 = $url32; URL64 = $url64; Version = $version;
        PackageName32 = $PackageName32
        PackageName64 = $PackageName64
        #Diabled until au/issues/36
        # Checksum32     = $checksum32
        # Checksum64     = $checksum64
        # ChecksumType32 = $hashtype32
        # ChecksumType64 = $hashtype64
        ChecksumType32 = $ChecksumType
        ChecksumType64 = $ChecksumType
    }
}

update -ChecksumFor none
