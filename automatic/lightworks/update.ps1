import-module au

$domain = 'https://www.lwks.com'
$releases = "$domain/index.php?option=com_lwks&view=download&Itemid=206&tab=0"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function Get-UrlFromPage([string]$url) {
  $dlPage = Invoke-WebRequest $url -UseBasicParsing

  $url = $dlPage.Links | ? href -match "doc_download" | % href

  return Get-RedirectedUrl $url
}

function global:au_GetLatest {
  [System.Net.ServicePointManager]::SecurityProtocol = 'Ssl3,Tls,Tls11,Tls12' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/366
  $download_page = Invoke-WebRequest $releases -UseBasicParsing

  $url32 = Get-UrlFromPage ($download_page.Links | ? href -match "win_public_32" | % { $domain + $_.href })
  $url64 = Get-UrlFromPage ($download_page.Links | ? href -match "win_public_64" | % { $domain + $_.href })

  $version = $url64 -split '_' | select -last 1 -Skip 3

  @{
    Version = $version
    URL32   = $url32
    URL64   = $url64
  }
}

update
