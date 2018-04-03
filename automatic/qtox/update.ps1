import-module au

$softwareName = 'qTox'

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -FileNameBase "setup-$($softwareName)-$($Latest.Version)"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}

function parseUrlAndVersion() {
  param($releaseUrl)

  $download_page = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
  $url = $download_page.Links | ? href -match "setup-qtox(?:64|32)\-([\d\.]+)\.exe$" | select -first 1 -expand href
  $version = $url -split '-|\.exe$' | select -last 1 -Skip 1

  return @{ URL = $releaseUrl + $url; Version = $version.TrimStart('\.') }
}

function global:au_GetLatest {
  $data32 = parseUrlAndVersion "https://build.tox.chat/view/qtox/job/qTox_pkg_windows_x86_stable_release/"
  $data64 = parseUrlAndVersion "https://build.tox.chat/view/qtox/job/qTox_pkg_windows_x86-64_stable_release/"

  if ($data32.Version -ne $data64.Version) {
    throw "32bit and 64bit version do not match. Please Investigate..."
  }

  @{
    URL32    = $data32.URL
    URL64    = $data64.URL
    Version  = $data32.Version
    FileType = 'exe'
  }
}

update -ChecksumFor none
