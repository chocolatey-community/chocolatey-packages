Import-Module Chocolatey-AU

$releaseStableUrl = 'https://brave-browser-downloads.s3.brave.com/latest/release-windows-x64.version'
$releaseBetaUrl = 'https://brave-browser-downloads.s3.brave.com/latest/beta-windows-x64.version'

function global:au_GetLatest {
  # Beta releases
  $domainBeta = 'https://github.com'
  # Web url was provided at https://github.com/chocolatey-community/chocolatey-packages/issues/1791#issuecomment-1030152913
  $releaseBetaVersion = Invoke-RestMethod -Uri $releaseBetaUrl
  $url32_b = $domainBeta + ('/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentBetaSetup32.exe' -f $releaseBetaVersion)
  $url64_b = $domainBeta + ('/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentBetaSetup.exe' -f $releaseBetaVersion)
  $version_b = $releaseBetaVersion

  # Stable releases
  $domainStable = 'https://github.com'
  # Web url was provided at https://github.com/chocolatey-community/chocolatey-packages/issues/1791#issuecomment-1030152913
  $releaseStableVersion = Invoke-RestMethod -Uri $releaseStableUrl
  $url32 = $domainStable + ('/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentSetup32.exe' -f $releaseStableVersion)
  $url64 = $domainStable + ('/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentSetup.exe' -f $releaseStableVersion)
  $version = $releaseStableVersion

  $streams = @{
    stable = @{
      URL32         = $url32
      URL64         = $url64
      Version       = $version
      RemoteVersion = $version
      Title         = 'Brave Browser'
      IconUrl       = 'https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@a23ca306537e2537a574ddc55e9c28dc1151ab30/icons/brave.svg'
    }

    beta   = @{
      URL32         = $url32_b
      URL64         = $url64_b
      Version       = $version_b + '-beta'
      RemoteVersion = $version_b
      Title         = 'Brave Browser (Beta)'
      IconUrl       = 'https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@a23ca306537e2537a574ddc55e9c28dc1151ab30/icons/brave-beta.svg'
    }
  }

  if (!$url64 -and !$url64_b) {
    Write-Host "No stable and no beta release is available (Nightly not supported)..."
    return "ignore"
  }

  # Just because we have a version returned does not mean there is a Windows version available
  # if the URL is valid, it won't throw
  try {
    Invoke-RestMethod -Uri $url64 -UseBasicParsing -Method HEAD
  }
  catch {
    $streams.stable = 'ignore'
    Write-Host "No stable release is available"
  }

  # Just because we have a version returned does not mean there is a Windows version available
  # if the URL is valid, it won't throw
  try {
    Invoke-RestMethod -Uri $url64_b -UseBasicParsing -Method HEAD
  }
  catch {
    $streams.beta = 'ignore'
    Write-Host "No beta release is available"
  }

  @{ streams = $streams }
}

function global:au_BeforeUpdate {
  $stream_readme = if ($Latest.Title -like '*Beta*') { 'README-beta.md' } else { 'README-release.md' }
  Copy-Item $stream_readme $PSScriptRoot\README.md -Force
  Get-RemoteFiles -Purge -NoSuffix
  Remove-Item "$PSScriptRoot\tools\$($Latest.FileName32)"
}

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"                = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"       = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
      "(?i)([$]softwareVersion\s*=\s*)'.*'"       = "`${1}'$($Latest.RemoteVersion)'"
    }
    "legal\VERIFICATION.txt"      = @{
      "(?i)(x86_64:).*"     = "`${1} $($Latest.URL64)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
    "brave.nuspec"                = @{
      "(\<title\>).*(\<\/title\>)"     = "`${1}$($Latest.Title)`$2"
      "(\<iconUrl\>).*(\<\/iconUrl\>)" = "`${1}$($Latest.IconUrl)`$2"
    }
  }
}

update -ChecksumFor none
