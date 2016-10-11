import-module au

$releases = 'http://www.antp.be/software/renamer/download'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $re    = 'install\.exe'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = [regex]::Match($download_page.Content, "Version\s+([0-9\.]+)").Groups[1].Value;

    return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
