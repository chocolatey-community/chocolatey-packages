import-module au

$releases = 'https://pypi.python.org/pypi/mkdocs'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $re = 'mkdocs\/[\d\.]+$'
    $url = $download_page.links | ? href -match $re | select -first 1 -expand href
    $version = $url -split '\/' | select -last 1

    return @{ Version = $version }
}

update -ChecksumFor none
