Import-Module AU

$releases = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows'
$softwareName = 'maxima*'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"   = "`${1}'$softwareName'"
      "(?i)^(\s*url\s*=\s*)'.*'"            = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*url64(bit)?\s*=\s*)'.*'"    = "`${1}'$($Latest.URL64)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"       = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'"   = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)^(\s*checksum64\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)^(\s*checksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function appendIfNeeded([string]$url) {
  if ($url -and !$url.StartsWith('http')) {
    return New-Object uri([uri]$releases, $url)
  }
  else {
    return $url
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '[\d\.]+\-Windows\/$'
  $releasesUrl = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { appendIfNeeded $_ }
  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

  $re = 'win32\.exe\/download$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { appendIfNeeded $_ }

  $re = 'win64\.exe\/download$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href | % { appendIfNeeded $_ }

  $verRe = '-'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  $version64 = $url64 -split "$verRe" | select -last 1 -skip 1
  if ($version32 -ne $version64) {
    throw "32bit version do not match the 64bit version"
  }

  if ($version32 -match '[a-z]$') {
    [char]$letter = $version32[$version32.Length - 1]
    [int]$num = $letter - [char]'a'
    $num++
    $version32 = $version32 -replace $letter, ".$num"
  }

  $versionTwoPart = $version32 -replace '^(\d+\.\d+)\.[\d\.]+$', "`$1"

  @{
    URL32        = $url32
    URL64        = $url64
    Version      = $version32
    ReleaseNotes = "https://sourceforge.net/p/maxima/code/ci/master/tree/ChangeLog-$($versionTwoPart).md"
  }
}

update
