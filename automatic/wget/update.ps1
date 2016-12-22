import-module au

$releases = 'https://eternallybored.org/misc/wget/'

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"           = "`${1} $($Latest.URL32)"
            "(?i)(\s+x64:).*"           = "`${1} $($Latest.URL64)"
            "(?i)(\s+checksum32:).*"    = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"    = "`${1} $($Latest.Checksum64)"
            "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}


function global:au_BeforeUpdate { Get-RemoteFiles -Purge }


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $regex = '.zip$'
    $url = $download_page.links | ? href -match $regex | select -First 2 -expand href
    
    $version = $url[0] -split '-' | select -Last 1 -Skip 1
    
    $url32 = 'https://eternallybored.org/misc/wget/' + $url[0]
    $url64 = 'https://eternallybored.org/misc/wget/' + $url[1]
    
    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update -ChecksumFor none
