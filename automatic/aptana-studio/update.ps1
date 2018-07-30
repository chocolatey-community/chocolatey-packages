import-module au

$domain   = 'https://github.com'
$releases = "$domain/aptana/studio3/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate {
  @{
    Version = $Latest.RemoteVersion
    URL32 = $Latest.URL32
  } | ConvertTo-Json | Out-File "$PSScriptRoot\url.json" -Encoding utf8
  $global:au_Force = $false
}

function HasUrlChanged([string]$version, [string]$url)
{
  if (Test-Path "$PSScriptRoot\url.json") {
    $info = Get-Content "$PSScriptRoot\url.json" -Encoding UTF8 | ConvertFrom-Json
    if (!$info.URL32) { return $false } # We don't want the update to be forced if no previous url is set
    if ($info.Version -eq $version -and $info.URL32 -ne $url) {
      # Let us test if the older url actually still works, if not we'll return true
      try {
        Invoke-WebRequest -UseBasicParsing -Uri $info.URL32 -Method Head | Out-Null
        return $false
      }
      catch {
        return $true
      }
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = '\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $version  = $url -split '/' | select -Last 1 -Skip 1
  $version = $version.TrimStart('v') -replace "^([\d]+\.[\d+]\.[\d]+)\..*$",'$1'

  if ($url.StartsWith('/')) {
    $url = $domain + $url
  }

  if (HasUrlChanged -version $version -url $url) {
    $global:au_Force = $true
  }

  @{
    URL32 = $url
    Version = $version
    RemoteVersion = $version
  }
}

update -ChecksumFor 32
