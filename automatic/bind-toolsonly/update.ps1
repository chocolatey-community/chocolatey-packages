import-module au

$releases = 'https://downloads.isc.org/isc/bind9/'

function global:au_BeforeUpdate {
  return Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\legal\verification.txt" = @{
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum64 type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
      "(?i)(Get-RemoteChecksum\s+).*" = "`${1}'$($Latest.URL64)'"
    }
    ".\bind-toolsonly.nuspec"= @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
      "(\<docsUrl\>).*?(\</docsUrl\>)" = "`${1}$($Latest.DocsURL)`$2"
    }
  }
}

function global:au_GetLatest {
  $current_url = $releases + 'cur/'
  try {
    $current_page = Invoke-WebRequest -UseBasicParsing -Uri $current_url
  } catch {
    if ($_ -match "Unable to connect to the remote server") {
      Write-Host "download.isc.org is down, skipping package update..."
      return "ignore"
    } else {
      throw $_
    }
  }

  $version_regex = '^\d+\.\d*[02468]/?$'
  $latest_url = $current_page.links `
    | Where-Object href -match $version_regex `
    | Select-Object -Last 1 -expand href
  $latest_url = $current_url + $latest_url

  try {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $latest_url
  } catch {
    if ($_ -match "Unable to connect to the remote server") {
      Write-Host "download.isc.org is down, skipping package update..."
      return "ignore"
    } else {
      throw $_
    }
  }

  $download_regex = '\.zip$'
  $fileName = $download_page.links `
    | Where-Object href -match $download_regex `
    | Select-Object -Skip 1 -First 1 -expand href

  $version = (,9 + ($fileName -split '\.' | Select-Object -Skip 1 -First 2)) -join '.'
  $url = $releases + $version + '/';

  $fileUrl = $url + $fileName
  $docsUrl = $url + 'doc/arm/html/'
  $releaseNotesUrl = $docsUrl + 'notes.html'

  return @{
    URL64 = $fileUrl
    DocsURL = $docsUrl
    ReleaseNotes = $releaseNotesUrl
    Version = $version
    FileName64 = $fileName
  }
}

update -ChecksumFor none
