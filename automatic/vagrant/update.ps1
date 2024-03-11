Import-Module Chocolatey-AU

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
    $version_url   = $download_page.Links | Where-Object href -match 'vagrant' | ForEach-Object href | Select-Object -first 1
    $version_url   = 'https://releases.hashicorp.com' + $version_url

    $download_page = Invoke-WebRequest -Uri $version_url -UseBasicParsing
    $link = $download_page.links | Where-Object href -match '\.msi$'

    @{
        Version  = $link.'data-version' | Select-Object -first 1
        URL32    = $link.href -notmatch '_amd64' | Select-Object -First 1
        URL64    = $link.href -match '_amd64'    | Select-Object -First 1
    }
}

update
