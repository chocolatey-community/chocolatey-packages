import-module au
. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"

$releases = 'http://www.jubler.org/download.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_AfterUpdate {
  Set-DescriptionFromReadme -SkipFirst 2
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = 'jubler.*\.exe'
  $urls   = $download_page.links | ? href -match $re | select -First 2 -expand href

  $version  = $urls[0] -split '[_-]' | select -Last 1 -Skip 1

  @{
    URL32 = $urls -notmatch "64\.exe" | select -first 1
    URL64 = $urls -match "64\.exe" | select -first 1
    Version = $version
  }
}


try {
    update
} catch {
    $ignore = "Unable to connect to the remote server"
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}

