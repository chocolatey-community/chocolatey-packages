import-module au

$releases = 'http://wincdemu.sysprogs.org/download'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.exe'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = ($url -split '-' | select -Last 1).Replace('.exe','')

    @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
