import-module au

$releases = 'https://www.telerik.com/download/fiddler'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version  = $download_page.Content -match 'Version (4(\.[0-9]+)+)'
    @{
        Version = $Matches[1]
        URL32   = 'https://www.telerik.com/docs/default-source/fiddler/fiddlersetup.exe'
    }
}

update -ChecksumFor 32
