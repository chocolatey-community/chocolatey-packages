<<<<<<< HEAD
﻿Import-Module AU
=======
Import-Module AU
>>>>>>> (itunes) Added AU update script

$releases     = 'https://www.apple.com/itunes/download/'
$softwareName = 'iTunes'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"   = "`${1}'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)'.*'"  = "`${1}'$softwareName'"
      "(?i)(^\s*url\s*=\s*)'.*'"           = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*url64(bit)?\s*=\s*)'.*'"   = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)'.*'"      = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)'.*'"  = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksum64\s*=\s*)'.*'"    = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType64\s*=\s*)'.*'"= "`${1}'$($Latest.ChecksumType64)'"
      "(?i)(^[$]version\s*=\s*)'.*'"       = "`${1}'$($Latest.RemoteVersion)'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $iframeLink = $download_page.AllElements | ? title -eq 'Please select a download.' | select -first 1 -expand src

  $download_page = Invoke-WebRequest -Uri $iframeLink

  $re = 'iTunesSetup\.exe$'
  $url32 = $download_page.InputFields | ? value -match $re | select -first 1 -expand value

  $re = 'iTunes6464Setup\.exe$'
  $url64 = $download_page.InputFields | ? value -match $re | select -first 1 -expand value

  $re = '^iTunes ([\d\.]+) for Windows'
  $versionLink = $download_page.InputFields | ? value -match $re | select -first 1 -expand value
  if ($versionLink) {
    $version = $Matches[1]
  }

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version
    RemoteVersion = $version
  }
}

update
