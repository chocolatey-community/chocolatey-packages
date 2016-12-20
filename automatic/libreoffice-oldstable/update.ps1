import-module au

$releases = 'https://www.libreoffice.org/download/libreoffice-still'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.links | ? href -match '\.msi$' | % href | select -First 1
    $version = $url -split '/' | ? { [version]::TryParse($_,[ref]($__)) }
    @{
        Version = $version
        URL32   = "https://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86.msi"
        URL64   = "https://download.documentfoundation.org/libreoffice/stable/${version}/win/x86_64/LibreOffice_${version}_Win_x64.msi"
    }
}

update
