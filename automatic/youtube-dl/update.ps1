import-module au

$domain   = 'https://github.com'
$releases = "$domain/rg3/youtube-dl/releases/latest"

function global:au_afterUpdate {
  rm $PSScriptRoot/tools/*.exe -ea Ignore
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re    = '\.exe$'
  $url   = $domain + ($download_page.Links | ? href -match $re | select -First 1 -expand href)
  $filename = $url.Substring($url.LastIndexOf('/') + 1)
  $version  = $url -split '\/' | select -skip 1 -last 1

  $checksumAsset = $domain + ($download_page.Links | ? href -match "SHA2\-512SUMS$" | select -first 1 -expand href)
  $checksum_page = Invoke-WebRequest -Uri $checksumAsset
  $checksum = [regex]::Match($checksum_page, "([a-f\d]+)\s*$([regex]::Escape($filename))").Groups[1].Value

  return @{
    Version = $version
    URL32 = $url
    Checksum32 = $checksum
    ChecksumType32 = "sha512"
  }
}

update -ChecksumFor 32
