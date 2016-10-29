import-module au

$releases = 'http://download.documentfoundation.org/libreoffice/stable'

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
    $version = $download_page.links | ? { [version]::TryParse($_.href.Replace('/',''), [ref]($v)) } | % href | sort -desc | select -first 1
    $version = $version.Replace('/','')
    @{
        Version = $version
        URL32 = "$releases/${version}/win/x86/LibreOffice_${version}_Win_x86.msi"
        URL64 = "$releases/${version}/win/x86_64/LibreOffice_${version}_Win_x64.msi"
    }
}

update
