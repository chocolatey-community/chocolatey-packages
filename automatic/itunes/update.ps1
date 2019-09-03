Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\scripts/au_extensions.psm1"

$softwareName = 'iTunes'
$padUnderVersion = '12.9.6'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"    = "`${1}'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)'.*'"   = "`${1}'$softwareName'"
      "(?i)(^\s*url\s*=\s*)'.*'"            = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*url64(bit)?\s*=\s*)'.*'"    = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)'.*'"       = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)'.*'"   = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksum64\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
      "(?i)(^[$]version\s*=\s*)'.*'"        = "`${1}'$($Latest.RemoteVersion)'"
    }
  }
}

function GetResultInformation([string]$url32, [string]$url64) {
  $url32 = Get-RedirectedUrl $url32
  $url64 = Get-RedirectedUrl $url64
  $dest = "$env:TEMP\itunes.exe"

  Get-WebFile $url32 $dest | Out-Null
  $checksumType = 'sha256'
  $version = Get-Item $dest | % { $_.VersionInfo.ProductVersion }
  $checksum32 = Get-FileHash $dest -Algorithm $checksumType | % Hash
  rm -force $dest

  return @{
    URL32          = $url32
    URL64          = $url64
    Version        = Get-FixVersion $version -OnlyFixBelowVersion $padUnderVersion
    RemoteVersion  = $version
    Checksum32     = $checksum32
    ChecksumType32 = $checksumType
    Checksum64     = Get-RemoteChecksum $url64 -Algorithm $checksumType
    ChecksumType64 = $checksumType
    PackageName    = 'iTunes'
  }
}

function global:au_GetLatest {
  $url32 = 'https://www.apple.com/itunes/download/win32'
  $url64 = 'https://www.apple.com/itunes/download/win64'

  Update-OnETagChanged -execUrl "https://www.apple.com/itunes/download/win32" `
    -OnETagChanged {
    GetResultInformation $url32 $url64
  } -OnUpdated { @{ URL32 = $url32 ; URL64 = $url64 ; PackageName = 'iTunes' }}
}

update -ChecksumFor none
