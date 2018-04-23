import-module au
Import-Module "$env:ChocolateyInstall/helpers/chocolateyInstaller.psm1"

$release = 'https://go.skype.com/classic.skype'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function GetResultInformation([string]$url32) {
  $dest = "$env:TEMP\skype.exe"
  Get-WebFile $url32 $dest | Out-Null
  $chType = 'SHA256'

  try {
    return @{
      URL32          = $url32
      Version        = Get-Item $dest | % { $_.VersionInfo.FileVersion }
      Checksum32     = Get-FileHash $dest -Algorithm $chType | % Hash
      ChecksumType32 = $chType
    }
  }
  finally {
    Remove-Item -Force $dest
  }
}

function global:au_GetLatest {
  $url32 = Get-RedirectedUrl -url $release

  return Update-OnETagChanged -execUrl $url32 -OnETagChanged {
    GetResultInformation $url32
  } -OnUpdate { @{ URL32 = $url32 }}
}

update -ChecksumFor none
