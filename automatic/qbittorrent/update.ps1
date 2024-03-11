Import-Module Chocolatey-AU

$releases = 'http://www.qbittorrent.org/download.php'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameSkip 1 -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\verification.txt" = @{
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  try {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  } catch {
    if ($_ -match "Unable to connect to the remote server") {
      Write-Host "qbittorrent.org is down, skipping package update..."
      return "ignore"
    } else {
      throw $_
    }
  }

  $re    = 'setup\.exe\/download$'
  $urls  = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
  $url64 = $urls | Where-Object { $_ -match "x64" } | Select-Object -first 1

  $version64 = $url64 -split '[_]' | Select-Object -Last 1 -Skip 2

  return @{
    URL64    = $url64
    Version  = $version64
    FileType = 'exe'
  }
}

update -ChecksumFor none
