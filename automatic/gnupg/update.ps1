import-module au

$releases = 'https://www.gnupg.org/download/index.en.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    
    $regex = 'exe$'
    $url = $download_page.links | ? href -match $regex | select -First 1 -expand href
    $url = 'https://www.gnupg.org' + $url
    
    $version = $url -split '-|_|.exe' | select -Last 1 -Skip 2
    
    $Latest = @{ URL32 = $url; Version = $version }
    return $Latest
}

update -ChecksumFor 32
