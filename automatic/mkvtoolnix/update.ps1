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

    $versionSort = { [version]($_.href.TrimEnd('/')) }
    $version = $download_page.links | ? href -match "^\d+\.[\d\.]+\/" `
      | sort $versionSort -Descending | select -first 1 -expand href | % { $_.TrimEnd('/') }

    $releases = "$releases/$version/"
    $re = '^mkvtoolnix-.+\.exe$'
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.links | ? href -match $re | % href | unique
    @{
        URL32   = "$releases" + ($url -match '32\-?bit' | Select -First 1)
        URL64   = "$releases" + ($url -match '64\-?bit' | select -First 1)
        Version = $version
    }
}

update
