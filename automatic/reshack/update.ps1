Import-Module Chocolatey-AU

$releases = 'http://www.angusj.com/resourcehacker'

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
    $download_page = Invoke-WebRequest -Uri $releases
    $re = '<h3>Download version (.+?):</h3>'
    $download_page.Content -match $re | Out-Null
    $version = $Matches[1].Trim()
    $url =  $download_page.Links | Where-Object href -match 'exe' | ForEach-Object href | Select-Object -First 1
    $url = "$releases/$url"

    @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
