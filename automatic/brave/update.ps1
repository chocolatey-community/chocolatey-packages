import-module au

$releases = 'https://github.com/brave/brave-browser/releases'

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $domain = $releases -split '(?<=//.+)/' | select -First 1
  $url32_b = $download_page.links | ? href -match 'SilentBetaSetup32.exe$' | select -First 1 -expand href
  $url64_b = $download_page.links | ? href -match 'SilentBetaSetup.exe$' | select -First 1 -expand href
  $version_b = $url32_b -split '/v?' | select -Skip 1 -Last 1

  for ($i = 0; $i -lt 10; $i++) {
    $url32 = $download_page.links | ? href -match 'StandaloneSilentSetup32.exe$' | select -First 1 -expand href
    $url64 = $download_page.links | ? href -match 'StandaloneSilentSetup.exe$' | select -First 1 -expand href
    $version = $url32 -split '/v?' | select -Skip 1 -Last 1
    if ($url32 -and $url64) {
      break
    }
    $nextUrl = $download_page.Links | ? outerHTML -match "Next" | % href
    if (!$nextUrl) { break }
    $download_page = Invoke-WebRequest -Uri $nextUrl -UseBasicParsing
  }

  $streams = @{
    stable = @{
      URL32         = $domain + $url32
      URL64         = $domain + $url64
      Version       = $version
      RemoteVersion = $version
      Title         = 'Brave Browser'
      IconUrl       = 'https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@a23ca30653/icons/brave.svg'
    }

    beta   = @{
      URL32         = $domain + $url32_b
      URL64         = $domain + $url64_b
      Version       = $version_b + '-beta'
      RemoteVersion = $version_b
      Title         = 'Brave Browser (Beta)'
      IconUrl       = 'https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@a23ca30653/icons/brave-beta.svg'
    }
  }

  if (!$url64 -and !$url64_b) {
    Write-Host "No stable and no beta release is available (Nightly not supported)..."
    return "ignore"
  }

  if (!$url64) { $streams.stable = 'ignore'; Write-Host "No stable release is available" }
  if (!$url64_b) { $streams.beta = 'ignore'; Write-Host "No beta release is available" }
  elseif (!$url32_b) { $streams.beta = "ignore"; Write-Host "No 32bit beta release is available" }
  @{ streams = $streams }
}

function global:au_BeforeUpdate {
  $stream_readme = if ($Latest.Title -like '*Beta*') { 'README-beta.md' } else { 'README-release.md' }
  cp $stream_readme $PSScriptRoot\README.md -Force
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
      "(?i)([$]softwareVersion\s*=\s*)'.*'"       = "`${1}'$($Latest.RemoteVersion)'"
    }
    "legal\VERIFICATION.txt"      = @{
      "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
      "(?i)(x86_64:).*"     = "`${1} $($Latest.URL64)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
    "brave.nuspec"                = @{
      "(\<title\>).*(\<\/title\>)"     = "`${1}$($Latest.Title)`$2"
      "(\<iconUrl\>).*(\<\/iconUrl\>)" = "`${1}$($Latest.IconUrl)`$2"
    }
  }
}

update -ChecksumFor none
