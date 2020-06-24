import-module au

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix

  $verifyContent = Invoke-WebRequest -Uri $Latest.verify_url -UseBasicParsing | % { [System.Text.Encoding]::UTF8.GetString($_.Content) }

  $verifyContent -match "(?smi)^([a-f\d]+)\s*\*$($Latest.FileName32)"
  $url32Hash = $Matches[1]
  if ($url32Hash -ne $Latest.Checksum32) {
    throw "File checksum of downloaded 32bit executable do not match expected upstream checksum"
  }

  $verifyContent -match "(?smi)^([a-f\d]+)\s*\*$($Latest.FileName64)"
  $url64Hash = $Matches[1]
  if ($url64Hash -ne $Latest.Checksum64) {
    throw "File checksum of downloaded 64bit executable do not match expected upstream checksum"
  }
}

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt"      = @{
      "(?i)(32-Bit.+)\<.*\>"                       = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>"                       = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*"                  = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum32:\s+).*"                     = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*"                     = "`${1}$($Latest.Checksum64)"
      "(?i)(downloaded.*release page\:?\s*)\<.*\>" = "`${1}<$($Latest.web_url)>"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
  $headers = @{}
  if (Test-Path Env\:github_api_key) {
    $headers["Authorization"] = "token $env:github_api_key"
  }
  $jsonAnswer = Invoke-RestMethod `
    -Uri "https://api.github.com/repos/keeweb/keeweb/releases/latest" `
    -Headers $headers `
    -UseBasicParsing

  $version = $jsonAnswer.tag_name -Replace '[^0-9.]'
  $jsonAnswer.assets | Where { $_.name -cmatch "(32|x64).exe" } | ForEach-Object {
    if ($_.browser_download_url -Match 'x64') {
      $url64 = $_.browser_download_url
      $filename64 = $_.name
    }
    else {
      $url32 = $_.browser_download_url
      $filename32 = $_.name
    }
  }

  $verifyUrl = ($jsonAnswer.assets | Where { $_.name -Match "Verify.sha256" }).browser_download_url

  return @{
    url32          = $url32;
    url64          = $url64;
    verify_url     = $verifyUrl
    checksumType32 = 'SHA256';
    checksumType64 = 'SHA256';
    version        = $version;
    web_url        = $jsonAnswer.html_url
  }
}

update -ChecksumFor none
