import-module au

$releases = 'http://ejie.me'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $version = ($download_page).Content -match 'Version:(.|\n)+?\</small\>'
    $version = $Matches[0] -split '<|>' | select -Last 1 -Skip 4
    $url     = "http://ejie.me/uploads/setup_clover@${version}.exe"

    @{ URL32 = $url; Version = $version; PackageName = 'Clover' }
}

#update -ChecksumFor 32
Write-Host "Update is disabled due to several virus results on virustotal"
return "ignore"
