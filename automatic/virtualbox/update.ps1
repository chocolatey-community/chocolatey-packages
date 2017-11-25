import-module au
import-module .\..\..\extensions\extensions.psm1

$releases = 'https://www.virtualbox.org/wiki/Download_Old_Builds'

function GetLatest {
  param([string]$releaseUrl)

  $download_page = Invoke-WebRequest -uri $releaseUrl -UseBasicParsing

  $url      = $download_page.links | ? href -match '\.exe$' | select -first 1 -expand href
  $version  = $url -split '/' | select -Last 1 -Skip 1
  $base_url = $url -replace '[^/]+$'
  @{
    URL32         = $url
    URLep         = "${base_url}Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"
    Version       = $version
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

$cert = ls cert: -Recurse | ? { $_.Thumbprint -eq 'a88fd9bdaa06bc0f3c491ba51e231be35f8d1ad5' }
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

  $links = $builds_page.Links | ? href -match 'Builds_[\d_]+$' | select -expand href

  $streams = [ordered] @{}

  $latest = GetLatest "https://www.virtualbox.org/wiki/Downloads"

  $streams.Add((Get-Version $Latest.Version).ToString(2), $latest)

  $links | % {
    $versionPart = $_ -split 'Builds_' | select -last 1 | % { $_ -replace '_','.' }

    if (!$streams.Contains($versionPart)) {
      $streams.Add($versionPart, (GetLatest "https://www.virtualbox.org$_"))
    }
  }

  return @{ Streams = $streams}
}

Update -ChecksumFor 32
