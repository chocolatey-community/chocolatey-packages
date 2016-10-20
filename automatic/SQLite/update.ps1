import-module au

$releases = 'https://sqlite.org/download.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $version = $download_page.AllElements | ? tagName -eq 'td' | ? InnerHtml -match '32-bit DLL .+ for SQLite version' | % InnerHtml
    $version -match '((?:\d+\.)+)' | out-null
    $version = $Matches[0] -replace '\.$'

    $version_txt = $version -replace '\.'
    $re  = '\-win\d\d\-.+\.zip'
    $url = $download_page.links | ? href -match $re | ? href -match $version_txt | % href | select -First 1
    $url = 'https://sqlite.org/' + $url

    @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
