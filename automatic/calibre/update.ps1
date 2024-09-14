Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://download.calibre-ebook.com/7.html'

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $versionHyperlink = $download_page.links | Select-Object -First 1
    if ($versionHyperlink.Title -notmatch 'Release (7[\d\.]+)' ) { throw "Calibre version 7.x not found on $releases" }

    $version = $versionHyperlink.InnerText
    $url64   = 'https://download.calibre-ebook.com/<version>/calibre-64bit-<version>.msi'
    $url64   = $url64 -replace '<version>', $version

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor none
