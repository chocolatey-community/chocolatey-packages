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
  $digestUrl = $url.Replace('.msi', '.msi.DIGEST')
  try {
    $downloadedPage = Invoke-WebRequest -Uri $digestUrl -UseBasicParsing -ErrorAction SilentlyContinue
    if ($downloadedPage) {
      $content = [System.Text.Encoding]::UTF8.GetString($downloadedPage.Content)
      $lines = $content -split "`r`n" | Where-Object { $_ -ne "" }
      foreach ($line in $lines) {
        $parsed = $line -split '\s+' | Where-Object { $_ -ne "" }
        if ($parsed.Count -ge 2 -and $parsed[-1] -eq $filename) {
          return $parsed[0]
        }
      }
    }
  } catch {
    Write-Warning "Could not retrieve hash from DIGEST file: $_"
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
  
  $asset = $jsonAnswer.assets | Where-Object { $_.name -Match "x64\.msi$" } | Select-Object -First 1
  if (-not $asset) {
    throw "No x64.msi asset found in the latest release"
  }
  
  $url64 = $asset.browser_download_url
  $fileName64 = $asset.name
  
  # Get checksum from DIGEST file
  $checksum64 = ""
  try {
    $digestUrl = $url64.Replace('.msi', '.msi.DIGEST')
    $downloadedPage = Invoke-WebRequest -Uri $digestUrl -UseBasicParsing -ErrorAction SilentlyContinue
    if ($downloadedPage) {
      $downloadedContent = [System.Text.Encoding]::UTF8.GetString($downloadedPage.Content)
      $lines = $downloadedContent -split "`r`n" | Where-Object { $_ -ne "" }
      foreach ($line in $lines) {
        $parsed = $line -split '\s+' | Where-Object { $_ -ne "" }
        if ($parsed.Count -ge 2 -and $parsed[-1] -eq $fileName64) {
          $checksum64 = $parsed[0]
          break
        }
      }
    }
  } catch {
    Write-Warning "Could not retrieve checksum from DIGEST file: $_"
  }

  return @{
    URL64          = $url64;
    FileName64     = $fileName64;
    Checksum64     = $checksum64;
    ChecksumType64 = 'SHA256';
    Version        = $version;
    web_url        = $jsonAnswer.html_url
  }
}

update -ChecksumFor none
