import-module au

$releases = 'http://www.nirsoft.net/utils/nircmd.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $download_page.RawContent -match 'NirCmd v(.+)' | Out-Null

    $version = $Matches[1]
    $url32   = 'http://www.nirsoft.net/utils/nircmd.zip'
    $url64   = 'http://www.nirsoft.net/utils/nircmd-x64.zip'

    @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update
