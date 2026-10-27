Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

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
  $release = Get-GitHubRelease -Owner 'teras' -Name 'Jubler'

  $asset = $release.assets | Where-Object name -match 'Jubler-.*-x64\.exe$' | Select-Object -First 1
  if (-not $asset) { throw "No x64 installer asset found in the latest Jubler release." }

  @{
    URL64    = $asset.browser_download_url
    Version  = $release.tag_name -replace '^v', ''
    FileType = 'exe'
  }
}

update -ChecksumFor 64
