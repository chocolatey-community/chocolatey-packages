Import-Module AU
Import-Module Wormies-AU-Helpers
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\scripts/au_extensions.psm1"

$x64Release = 'https://aka.ms/vs/15/release/VC_redist.x64.exe'
$x86Release = 'https://aka.ms/vs/15/release/VC_redist.x86.exe'

function global:au_SearchReplace {
  @{
    ".\tools\data.ps1" = @{
      "^(?i)(\s*Url\s*=\s*)'.*'"                            = "`$1'$($Latest.URL32)'"
      "^(?i)(\s*Checksum\s*=\s*)'.*'"                       = "`$1'$($Latest.Checksum32)'"
      "^(?i)(\s*ChecksumType\s*=\s*)'.*'"                   = "`$1'$($Latest.ChecksumType32)'"
      "^(?i)(\s*Url64\s*=\s*)'.*'"                          = "`$1'$($Latest.URL64)'"
      "^(?i)(\s*Checksum64\s*=\s*)'.*'"                     = "`$1'$($Latest.Checksum64)'"
      "^(?i)(\s*ChecksumType64\s*=\s*)'.*'"                 = "`$1'$($Latest.ChecksumType64)'"
      "^(?i)(\s*ThreePartVersion\s*=\s*\[version\]\s*)'.*'" = "`$1'$($Latest.VersionThreePart)'"
    }
  }
}

function GetResultInformation([string]$url32, [string]$url64) {
  $url32 = Get-RedirectedUrl $url32
  $url64 = Get-RedirectedUrl $url64
  $dest = "$env:TEMP\vcredist140.exe"

  Get-WebFile $url32 $dest | Out-Null
  $checksumType = 'sha256'
  $version = Get-Version (Get-Item $dest | % { $_.VersionInfo.ProductVersion })
  $checksum32 = Get-FileHash $dest -Algorithm $checksumType | % { $_.Hash.ToLowerInvariant() }

  return @{
    URL32            = $url32
    URL64            = $url64
    Version          = if ($version.Version.Revision -eq '0') { $version.ToString(3) } else { $version.ToString() }
    VersionThreePart = $version.ToString(3)
    Checksum32       = $checksum32
    ChecksumType32   = $checksumType
    Checksum64       = Get-RemoteChecksum $url64 -Algorithm $checksumType
    ChecksumType64   = $checksumType
  }
}

function global:au_GetLatest {
  Update-OnETagChanged -execUrl $x64Release `
    -OnEtagChanged {
    GetResultInformation $x86Release $x64Release
  } -OnUpdated { @{ URL32 = $x86Release ; URL64 = $x64Release}}
}

update -ChecksumFor none
