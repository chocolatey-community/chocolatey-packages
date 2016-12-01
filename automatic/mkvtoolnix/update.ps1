import-module au

$releases = 'https://mkvtoolnix.download/windows/releases'


function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = $download_page.links | % { $_.href.Replace('/','') } | ? { [version]::TryParse($_, [ref]($__)) } | measure -Max | % Maximum

    $releases = "$releases/$version/"
    $re = '^mkvtoolnix-.+\.exe$'
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.links | ? href -match $re | % href | unique
    @{
        URL32   = "$releases" + ($url -match '32bit' | Select -First 1)
        URL64   = "$releases" + ($url -match '64bit' | select -First 1)
        Version = $version
    }
}

update
