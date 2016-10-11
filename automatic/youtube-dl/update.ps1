import-module au

$releases = 'https://api.github.com/repos/rg3/youtube-dl/releases/latest'

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
  $headers = @{}
  if (Test-Path Env:\github_api_key) {
    $headers.Authorization = 'Basic ' `
      + [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($env:github_api_key))
  }
  $download_page = Invoke-RestMethod -UseBasicParsing -Uri $releases -Headers $headers

  $re    = '\.exe$'
  $url   = $download_page.assets | ? browser_download_url -match $re | select -First 1 -expand browser_download_url
  $filename = $url.Substring($url.LastIndexOf('/') + 1);
  $version  = $download_page.tag_name;

  $checksumAsset = $download_page.assets | ? browser_download_url -match "SHA2\-512SUMS$" `
    | select -first 1 -expand browser_download_url
  $checksum_page = Invoke-WebRequest -UseBasicParsing -Uri $checksumAsset -Headers $headers;
  $checksum = [regex]::Match($checksum_page, "([a-f\d]+)\s*$([regex]::Escape($filename))").Groups[1].Value;

  return @{
    Version = $version
    URL32 = $url
    Checksum32 = $checksum
    ChecksumType32 = "sha512"
  };
}

update -ChecksumFor none
