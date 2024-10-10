Import-Module Chocolatey-AU

$releases = 'https://krita.org/en/download'

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url64 = $download_page.links | Where-Object href -Match 'x64.*-setup.exe$' | Select-Object -First 1 -expand href
  $version64 = $url64 -split '-' | Select-Object -Last 1 -Skip 1

  return @{
    URL64   = $url64
    Version = $version64
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{

    '.\tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }

    '.\legal\VERIFICATION.txt'      = @{
      '(?i)(x64:).*'        = "`${1} $($Latest.URL64)"
      '(?i)(checksum64:).*' = "`${1} $($Latest.Checksum64)"
      '(?i)(type:).*'       = "`${1} $($Latest.ChecksumType64)"
    }
  }

}

update -ChecksumFor none
