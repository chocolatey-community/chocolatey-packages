import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt"      = @{
      "(?i)(32-Bit.+)\<.*\>"      = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>"      = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum32:\s+).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*"    = "`${1}$($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*checksum\s*=\s*)'(.*)'"          = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)'(.*)'"        = "`${1}'$($Latest.Checksum64)'"
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

  $jsonAnswer = (
    Invoke-WebRequest `
      -Uri "https://api.github.com/repos/keepassxreboot/keepassxc/releases/latest" `
      -Headers @{"Authorization" = "token $env:github_api_key" } `
      -UseBasicParsing).Content | ConvertFrom-Json
  $version = $jsonAnswer.tag_name -Replace '[^0-9.]'
  $jsonAnswer.assets | Where { $_.name -Match "(Win32|Win64).msi$" } | ForEach-Object {
    if ($_.browser_download_url -cmatch 'Win64') {
      $url64 = $_.browser_download_url
      $filename64 = $_.name
      $hash64 = Get-Hash $url64 $filename64

    }
    elseif ($_.browser_download_url -cmatch 'Win32') {
      $url32 = $_.browser_download_url
      $filename32 = $_.name
      $hash32 = Get-Hash $url32 $filename32
    }
  }

  return @{
    url32          = $url32;
    url64          = $url64;
    checksum32     = $hash32;
    checksum64     = $hash64;
    checksumType32 = 'SHA256';
    checksumType64 = 'SHA256';
    filename32     = $filename32;
    filename64     = $filename64;
    version        = $version;
  }
}

update -ChecksumFor none
