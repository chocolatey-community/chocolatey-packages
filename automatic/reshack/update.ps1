import-module au

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
    $download_page.AllElements | ? tagName -eq 'strong' | ? InnerText -match '^Version' | % InnerText | set version
    $version = $version -split ' ' | select -Last 1
    $url =  $download_page.Links | ? href -match 'exe' | % href | Select -First 1
    $url = "$releases/$url"

    @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
