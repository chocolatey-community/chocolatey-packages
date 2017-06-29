import-module au

$releases = 'https://releases.hashicorp.com/vagrant'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version_url   = $download_page.Links | ? href -match 'vagrant' | % href | select -first 1
    $version_url   = 'https://releases.hashicorp.com' + $version_url

    $download_page = Invoke-WebRequest -Uri $version_url -UseBasicParsing
    $link = $download_page.links | ? href -match '\.msi$' 
    $url = 'https://releases.hashicorp.com'
    @{
        Version  = $link.'data-version' | select -first 1
        URL32    = $url + ($link.href -notmatch '_64' | select -First 1)
        URL64    = $url + ($link.href -match '_64'    | select -First 1)
    }
}

update
