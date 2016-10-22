import-module au

$releases = 'http://www.alldup.de/en_download_alldup.php'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = 'alldup.*\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = $download_page.links | ? href -match "alldup_version\.php$" | select -first 1 -expand innerText

    return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
