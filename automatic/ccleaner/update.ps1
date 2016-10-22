import-module au

$releases = 'http://www.piriform.com/ccleaner/download/standard'

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

    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href

    $download_page = Invoke-WebRequest https://www.piriform.com/ccleaner/version-history
    $version = $download_page.AllElements | ? tagName -eq 'h6' | % InnerText | select -first 1
    $version = $version -split ' ' | select -First 1
    $version = $version.Replace('v','')

    @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
