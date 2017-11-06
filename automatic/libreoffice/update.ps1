import-module au

$freshReleases = 'https://www.libreoffice.org/download/libreoffice-fresh'
$stillReleases = 'https://www.libreoffice.org/download/libreoffice-still'

function global:au_BeforeUpdate {
  if ($Latest.Title -like '*Fresh*') {
    cp "$PSScriptRoot\README.fresh.md" "$PSScriptRoot\README.md" -Force
  } else {
    cp "$PSScriptRoot\README.still.md" "$PSScriptRoot\README.md" -Force
  }
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\libreoffice.nuspec" = @{
          "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
        }
    }
}

function GetFreshVersion() {
  $download_page = Invoke-WebRequest -Uri $freshReleases -UseBasicParsing
  $url = $download_page.links | ? href -match '\.msi$' | % href | select -First 1
  $version = $url -split '/' | ? { [version]::TryParse($_, [ref]($__)) }

  @{
    PackageName = "libreoffice"
    Title = "LibreOffice Fresh"
    Version = $version
    URL32 = "https://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86.msi"
    URL64   = "https://download.documentfoundation.org/libreoffice/stable/${version}/win/x86_64/LibreOffice_${version}_Win_x64.msi"
  }
}

function GetStillVersions() {
  $download_page = Invoke-WebRequest -Uri $stillReleases -UseBasicParsing
  $url = $download_page.links | ? href -match '\.msi$' | % href | select -First 1
  $version = $url -split '/' | ? { [version]::TryParse($_,[ref]($__)) }

  @{
    PackageName = 'libreoffice-oldstable'
    Title = 'LibreOffice Still'
    Version = $version
    URL32   = "https://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86.msi"
    URL64   = "https://download.documentfoundation.org/libreoffice/stable/${version}/win/x86_64/LibreOffice_${version}_Win_x64.msi"
  }
}

function global:au_GetLatest {
  $streams = [ordered] @{
    fresh = GetFreshVersion
    still = GetStillVersions
  }

  return @{ Streams = $streams }
}

update
