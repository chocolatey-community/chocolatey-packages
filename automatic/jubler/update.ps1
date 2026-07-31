Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/teras/Jubler/releases/latest'

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(64\-Bit software\:\s*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)^(\s*url64bit\s*=\s*)'.*'"       = "`${1}'$($Latest.URL64)'"
      "(?i)^(\s*checksum64\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)^(\s*checksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re  = 'Jubler-.*-x64\.exe$'
  $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
  if ($url -notmatch '^https?://') { $url = 'https://github.com' + $url }

  if ($url -match 'Jubler-([\d.]+)-x64\.exe') { $version = $Matches[1] }

  @{
    URL64    = $url
    Version  = $version
    FileType = 'exe'
  }
}

update -ChecksumFor 64
