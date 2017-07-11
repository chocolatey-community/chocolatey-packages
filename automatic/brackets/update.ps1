import-module au

$releases = 'http://brackets.io'

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
    $download_page.links | ? InnerText -match 'Download Brackets' | % InnerText | set version
    $version = $version -replace 'Download Brackets '

    $download_page = Invoke-WebRequest https://github.com/adobe/brackets/releases
    $url = $download_page.links | ? href -match '\.msi$' | ? href -match $version | % href | select -First 1
    $url = 'https://github.com' + $url

    @{ URL32 = $url; Version = $version; PackageName = 'Brackets' }
}

update -ChecksumFor 32
