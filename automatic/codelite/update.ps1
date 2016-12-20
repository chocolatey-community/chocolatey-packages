import-module au

$domain   = "https://github.com"
$releases = "$domain/eranif/codelite/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
    ".\codelite.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotesUrl)</releaseNotes>"
    }
  }
}

function global:au_GetLatest () {
  $download_page = Invoke-WebRequest -Uri $releases

  $re = "codelite.*\.7z$"
  $urls = $download_page.links | ? href -match $re | select -first 2 -expand href
  $url32 = $domain + ($urls -match "x86" | select -first 1)
  $url64 = $domain + ($urls -match "amd64" | select -first 1)

  $releaseRe = "ReleaseNotesCodeLite[0-9]+$"
  $releaseNotes = $download_page.links | ? href -match $releaseRe | select -first 1 -expand href;

  $version = $url32 -split '[\-]|\.7z' | select -last 1 -skip 1;

  return @{
    URL32 = $url32
    URL64 = $url64
    ReleaseNotesUrl = $releaseNotes
    Version = $version
  }
}

update
