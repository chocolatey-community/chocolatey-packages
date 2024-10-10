Import-Module Chocolatey-AU
import-module .\..\..\extensions\extensions.psm1

$releases = 'https://www.virtualbox.org/wiki/Download_Old_Builds'

function GetLatest {
  param([string]$releaseUrl)

  $download_page = Invoke-WebRequest -uri $releaseUrl -UseBasicParsing

  $url      = $download_page.links | Where-Object href -match '\.exe$' | Select-Object -first 1 -expand href
  $version  = $url -split '/' | Select-Object -Last 1 -Skip 1
  $base_url = $url -replace '[^/]+$'
  @{
    URL32         = $url
    URLep         = "${base_url}Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"
    Version       = $version
  }
}

function global:au_AfterUpdate {
  $nuspecPath = ".\$($Latest.PackageName).nuspec"

  Clear-DependenciesList $nuspecPath
  Add-Dependency $nuspecPath 'chocolatey-core.extension' '1.3.3'

  if ([Version] $Latest.Stream -ge '7.0') {
    Add-Dependency $nuspecPath 'vcredist140' '14.20.27508.1'
  }
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*[$]url_ep\s*=\s*)('.*')"  = "`$1'$($Latest.URLep)'"
            "(?i)(^\s*[$]checksum_ep\s*=\s*)('.*')"  = "`$1'$(Get-RemoteChecksum $Latest.URLep)'"

        }
    }
}

$cert = Get-ChildItem cert: -Recurse | Where-Object { $_.Thumbprint -eq 'a88fd9bdaa06bc0f3c491ba51e231be35f8d1ad5' }
if (!$cert) {
    Write-Host "Adding oracle certificate"
    certutil -addstore 'TrustedPublisher' "$PSScriptRoot\tools\oracle.cer"
}

# if ($MyInvocation.InvocationName -ne '.') {
#   function global:au_GetLatest {
#     GetLatest $releases
#   }

#   update -ChecksumFor 32
# }

function global:au_GetLatest {
  $builds_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $links = $builds_page.Links | Where-Object href -match 'Builds_[\d_]+$' | Select-Object -expand href

  $streams = [ordered] @{}

  $latest = GetLatest "https://www.virtualbox.org/wiki/Downloads"

  $streams.Add((Get-Version $Latest.Version).ToString(2), $latest)

  $links | ForEach-Object {
    $versionPart = $_ -split 'Builds_' | Select-Object -last 1 | ForEach-Object { $_ -replace '_','.' }

    if (!$streams.Contains($versionPart)) {
      $streams.Add($versionPart, (GetLatest "https://www.virtualbox.org$_"))
    }
  }

  return @{ Streams = $streams}
}

Update -ChecksumFor 32
