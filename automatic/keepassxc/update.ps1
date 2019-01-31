import-module au

$releases = 'https://github.com/keepassxreboot/keepassxc/releases'

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

function appendBaseIfNeeded([string]$url) {
  if ($url -and !$url.StartsWith("http")) {
    return New-Object uri([uri]$releases, $url)
  }
  else {
    return $url
  }
}

function global:au_GetLatest {
  $downloadedPage = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $url32 = $downloadedPage.links | ? href -match 'Win32.msi$' | select -First 1 -expand href | % { appendBaseIfNeeded $_ }

  $url64 = $downloadedPage.links | ? href -match 'Win64.msi$' | select -First 1 -expand href | % { appendBaseIfNeeded $_ }
  $version = $url32 -split '/' | select -last 1 -skip 1

  if ($version -eq '2.4.0') {
    # Custom handling as we have already pushed that version by a mistake
    $version = $version + "." + (Get-Date -Format "yyyyMMdd")
  }

  return @{
    url32          = $url32;
    url64          = $url64;
    version        = $version;
  }
}

update -ChecksumFor none
