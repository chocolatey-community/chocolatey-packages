Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix

  $url64Hash = Get-Hash -url $Latest.URL64 -filename $Latest.FileName64
  if ($url64Hash -ne $Latest.Checksum64) {
    throw "File checksum of downloaded 64bit executable do not match expected upstream checksum"
  }
}

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt"      = @{
      "(?i)(64-Bit.+)\<.*\>"                       = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*"                  = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum64:\s+).*"                     = "`${1}$($Latest.Checksum64)"
      "(?i)(downloaded.*release page\:?\s*)\<.*\>" = "`${1}<$($Latest.web_url)>"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

# Since upstream is providing hashes, let's rely on these instead.
# i.e. this adds some added value as we are making sure the hashes are
# really those computed by upstream. We are not simply relying on the hashs
# provided by the cmdlet Get-RemoteFiles.
function Get-Hash($url, $filename) {
  $downloadedPage = Invoke-WebRequest -Uri "$url.DIGEST" -UseBasicParsing
  $downloadedPage = [System.Text.Encoding]::UTF8.GetString($downloadedPage.Content)
  $downloadedPage = $downloadedPage.Split([Environment]::NewLine)
  foreach ($line in $downloadedPage) {
    $parsed = $line -split ' |\n' -replace '\*', ''
    if ($parsed[1] -Match $filename) {
      return $parsed[0]
    }
  }
  return ""
}

function global:au_GetLatest {
  $headers = @{}
  if (Test-Path Env:\github_api_key) {
    $headers["Authorization"] = "token $env:github_api_key"
  }
  $jsonAnswer = Invoke-RestMethod `
    -Uri "https://api.github.com/repos/keepassxreboot/keepassxc/releases/latest" `
    -Headers $headers `
    -UseBasicParsing
  $version = $jsonAnswer.tag_name -Replace '[^0-9.]'
  $jsonAnswer.assets | Where-Object { $_.name -Match "Win64.msi$" } | ForEach-Object {
    $url64 = $_.browser_download_url
  }

  return @{
    url64          = $url64;
    checksumType64 = 'SHA256';
    version        = $version;
    web_url        = $jsonAnswer.html_url
  }
}

update -ChecksumFor none
