import-module au
. "./../../extensions/au_fosshub.ps1"

$releases = 'https://www.fosshub.com/qBittorrent.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]fosshubUrl\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = '\.exe$'
    $urlPart   = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url = "https://www.fosshub.com$urlPart"

    $version  = $url -split '[_]' | select -Last 1 -Skip 1

    return @{ URL32 = $url; Version = $version }
}

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-FosshubChecksum $Latest.URL32 $Latest.ChecksumType32
}

update -ChecksumFor none -NoCheckUrl -Force
