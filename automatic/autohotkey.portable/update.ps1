import-module au

$releases = 'https://autohotkey.com/download/1.1'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }
    }
}

function global:au_GetLatest {
    $version = Invoke-WebRequest -Uri "$releases\version.txt" -UseBasicParsing | % Content
    @{
        Version = $version
        URL32 = "$releases/AutoHotkey_${version}.zip"
    }
}

update -ChecksumFor 32
