import-module au

$releases = 'http://www.angusj.com/resourcehacker'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $download_page.AllElements | ? tagName -eq 'strong' | ? InnerText -match '^Version' | % InnerText | set version
    $version = $version -split ' ' | select -Last 1
    $url =  $download_page.Links | ? href -match 'exe' | ? InnerText -match $version | % href
    $url = "$releases/$url"

    @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
