import-module au

$releases = 'http://www.piriform.com/speccy/download/standard'

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

    $download_page = Invoke-WebRequest http://www.piriform.com/speccy/download
    $version = $download_page.AllElements | ? tagName -eq 'p' | ? InnerHtml -match 'Latest version'  | % innerHtml
    $version -match '([0-9]|\.)+' | Out-Null
    $version = $Matches[0]

   @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
