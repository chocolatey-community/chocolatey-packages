import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'http://download.calibre-ebook.com/2.html'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_AfterUpdate {
  Set-DescriptionFromReadme -SkipFirst 1
  Update-ChangelogDescription -version $Latest.Version
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $versionHyperlink = $download_page.links | select -First 1
    if ($versionHyperlink.Title -notmatch 'Release (2[\d\.]+)' ) { throw "Calibre version 2.x not found on $releases" }

    $version = $versionHyperlink.InnerText
    $url32   = 'https://download.calibre-ebook.com/<version>/calibre-<version>.msi'
    $url64   = 'https://download.calibre-ebook.com/<version>/calibre-64bit-<version>.msi'

    $url32   = $url32 -replace '<version>', $version
    $url64   = $url64 -replace '<version>', $version

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -ChecksumFor none
