import-module au

$releases = 'http://www.auslogics.com/en/software/disk-defrag-touch'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    ($download_page | % Content) -match '(?<=Latest\sver\..*?)[\d\.]{3,}'
    @{
        Version = $Matches[0]
        URL32   = 'http://downloads.auslogics.com/en/disk-defrag-touch/disk-defrag-touch-setup.exe'
    }
}

update -ChecksumFor 32
