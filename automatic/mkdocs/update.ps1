import-module au

$releases = 'https://pypi.python.org/pypi/mkdocs/json'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
     }
}

function global:au_GetLatest {
    $version = (Invoke-WebRequest -UseBasicParsing -Uri $releases | ConvertFrom-Json | Select -Expand info | Select version).version

    return @{ Version = $version }
}

update -ChecksumFor none