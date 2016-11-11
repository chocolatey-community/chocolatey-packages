import-module au

$releases = 'https://sourceforge.net/projects/ext2fsd/files/Ext2fsd'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $version = $download_page.Links | ? title -match '\.exe:' | % InnerText
    $version = $version -split '-| ' | ? {[version]::TryParse($_,[ref]($__))}

    $releases = "$releases/$version"
    $download_page = Invoke-WebRequest -Uri $releases
    $url = $download_page.Links | ? href -match '\.exe/download' | % href | select -First 1
    @{
        Version      = $version
        URL32        = $url
    }
}

update -ChecksumFor 32
