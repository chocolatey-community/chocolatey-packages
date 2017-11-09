import-module au

$releases = 'https://www.python.org/downloads'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
            "(^\s*url\s*=\s*)('.*')"         = "`$1'$($Latest.URL32)'"
            "(^\s*url64bit\s*=\s*)('.*')"    = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksum64\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function GetStreams() {
  param($releaseUrls)
  $streams = @{ }

  $releaseUrls | % {
    $version = $_.InnerText -split ' ' | select -last 1
    $versionTwoPart = $version -replace '([\d]+\.[\d]+).*',"`$1"

    if ($streams.ContainsKey($versionTwoPart)) { return }

    $baseUrl = [uri] "https://www.python.org$($_.href)"
    $download_page = Invoke-WebRequest -Uri $baseUrl -UseBasicParsing

    $url32 = $download_page.links | ? href -match "python\-[\d\.]+\.msi$" | select -first 1 -expand href
    $url64 = $download_page.links | ? href -match "python\-[\d\.]+\.amd64\.msi$" | select -first 1 -expand href
    if (!($url32) -and !($url64)) {
      Write-Host "Installers are missing for version '$version', skipping..."
      return;
    }
    if (!$url64) { $url64 = $url32 }
    $url32 = [uri]::new($baseUrl, $url32).ToString()
    $url64 = [uri]::new($baseUrl, $url64).ToString()

    $streams.Add($versionTwoPart, @{ URL32 = $url32 ; URL64 = $url64 ; Version = $version.ToString() })
  }

  return $streams
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $releaseUrls     = $download_page.links | ? { $_.href -match $re -and $_.InnerText -match "^Python 2\.[\d\.]+$" }

    return @{ Streams = GetStreams $releaseUrls }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced by the virtual package python
    update
}
