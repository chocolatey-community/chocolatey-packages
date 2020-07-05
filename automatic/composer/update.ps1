import-module au

$releases = 'https://github.com/composer/windows-setup/releases'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]fileName\s*=\s*)('.*')"      = "`$1'$($Latest.FileName32)'"
      "(?i)(checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(x32:).*"              = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $re = '\.exe$'
  $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
  $version = ($url -split '/' | Select-Object -Last 1 -Skip 1).Replace('v', '')
  @{
    URL32        = 'https://github.com' + $url
    Version      = $version
    ReleaseNotes = "https://github.com/composer/windows-setup/releases/tag/v${version}"
  }
}

update -ChecksumFor none
