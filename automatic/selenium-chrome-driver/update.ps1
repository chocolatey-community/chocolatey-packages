Import-Module Chocolatey-AU

$releases = "https://sites.google.com/chromium.org/driver/downloads"

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key 'releaseNotes' -value (Invoke-WebRequest -Uri $Latest.UrlReleaseNotes -UseBasicParsing -ContentType "text/plain" | ForEach-Object Content)
}

function global:au_GetLatest {
  $release_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $urls = $release_page.Links | Where-Object href -match "path=(\d+\.){3}\d+\/$" | Select-Object -expand href

  $streams = @{}

  $urls | Select-Object -first 3 | ForEach-Object {
    $version = $_ -split '=|/' | Select-Object -last 1 -skip 1
    $version = Get-Version $version
    [string]$streamName = $version.Version.Major

    if ($streams.ContainsKey($streamName)) {
      return
    }

    # We can not actually parse the download page easily, so make educated guesses
    $url = "https://chromedriver.storage.googleapis.com/$version/chromedriver_win32.zip"
    $release_notes = "https://chromedriver.storage.googleapis.com/$version/notes.txt"

    $streams["$streamName"] = @{
      URL32           = $url
      Version         = $version
      UrlReleaseNotes = $release_notes
      ReleasesUrl     = $_
      FileType        = 'zip'
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
