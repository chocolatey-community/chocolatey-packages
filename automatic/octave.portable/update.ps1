[CmdletBinding()]
param([switch] $Force)

Import-Module Chocolatey-AU

$releases = "https://ftp.gnu.org/gnu/octave/windows/?C=M;O=D"

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64 -Algorithm $Latest.checksumType64
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*64\-bit software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"      = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*"           = "`${1} $($Latest.Checksum64)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*\`$version\s*=\s*)('.*')"     = "`${1}'$($Latest.Version)'"
      "(?i)(^\s*Url64\s*=\s*)('.*')"          = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*Checksum64\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType64)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(<copyright>.*?-)\d{4}(.*?<\/copyright>)" = "`${1}$($Latest.UpdateYear)`${2}"
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re   = 'octave-.*-.*w64\.7z$'
  $url64 = $download_page.links | where-object href -match $re | select-object -First 1 -expand href | foreach-object{ New-Object uri([uri]$releases, $_) }

  $version64 = $url64 -split '[-]' | select-object -Last 1 -Skip 1

  $releases_url  = "https://www.gnu.org/software/octave/news.html"
  $releases_page = Invoke-WebRequest -Uri $releases_url -UseBasicParsing
  $re            = 'octave-.*-released'
  $releaseNotes  = $releases_page.links | where-object href -match $re | select-object -First 1 -expand href | foreach-object { New-Object uri([uri]$releases_url, $_) }

  return @{
    Version      = $version64.Replace('_', '.')
    URL64        = $url64
    ReleaseNotes = $releaseNotes
    UpdateYear   = (Get-Date).ToString('yyyy')
    ChecksumType64 = 'sha256'
  }
}

update -ChecksumFor none -Force:$Force
