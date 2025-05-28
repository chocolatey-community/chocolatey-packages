Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

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
    $githubLatestRelease = "https://github.com/kovidgoyal/calibre/releases/latest"
    $download_page = Invoke-WebRequest -Uri $githubLatestRelease -UseBasicParsing

    $versionHyperlink = $download_page.BaseResponse.ResponseUri

    $version =  ($versionHyperlink.Segments | Select-Object -Last 1).trim("v")
    $url64   = 'https://download.calibre-ebook.com/<version>/calibre-64bit-<version>.msi'
    $url64   = $url64 -replace '<version>', $version

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor none
