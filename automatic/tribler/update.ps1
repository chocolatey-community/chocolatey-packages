import-module au

$releases = 'https://www.tribler.org/download.html'

function global:au_SearchReplace {
  @{
    ".\tribler.nuspec" = @{
      "(<releaseNotes>).+" = "`$1$($Latest.ReleaseNotes)</releaseNotes>"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re    = 'Tribler.*\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $tag = $url -split '\/' | select -Last 1 -Skip 1
  $version  = $tag.TrimStart('v')
  $releaseNotesUrl = "https://github.com/Tribler/tribler/releases/tag/${tag}"

  return @{ URL32 = $url; Version = $version; releaseNotes = $releaseNotesUrl }
}

update -ChecksumFor 32
