import-module au

$releases = 'https://www.gnupg.org/download/index.en.html'

function global:au_BeforeUpdate {
  return Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\legal\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  try {
    $download_page = Invoke-WebRequest -Uri $releases
  } catch {
    if ($_ -match "Unable to connect to the remote server") {
      Write-Host "gnupg.org is down, skipping package update..."
      return "ignore"
    } else {
      throw $_
    }
  }

  $regex = 'exe$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
  $url = 'https://www.gnupg.org' + $url

  $version = $url -split '-|_|.exe' | Select-Object -Last 1 -Skip 2
  $fileName = $url -split '/' | Select-Object -Last 1

  return @{
    URL32 = $url
    Version = $version
    FileType = 'exe'
    FileName32 = $fileName
  }
}

update -ChecksumFor none
