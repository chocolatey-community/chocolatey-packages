import-module au
Import-Module "$env:ChocolateyInstall/helpers/chocolateyInstaller.psm1"

$release = 'https://go.skype.com/skype.download'

function global:au_BeforeUpdate {
  $checksumType = $Latest.ChecksumType32 = 'sha256'

  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.URL32 -Algorithm $checksumType
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $url32 = Get-RedirectedUrl -url $release
  $version = $url32 -split '\-|\.exe$' | select -Last 1 -Skip 1
  return @{
    URL32 = $url32
    Version = $version
  }
}

update -ChecksumFor none
