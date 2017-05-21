import-module au

$releases = 'https://sourceforge.net/projects/avidemux/files/avidemux'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }

    ".\tools\VERIFICATION.txt" = @{
      "(?i)(\s+x32:).*" = "`${1} $($Latest.URL32)"
      "(?i)(\s+x64:).*" = "`${1} $($Latest.URL64)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
      "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
    }
  }
}
function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $url = $download_page.links | ? href -match 'avidemux/[0-9.]+/$' | % href | select -First 1
  $url = 'https://sourceforge.net' + $url

  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32 = $download_page.Links | ? href -match "win32\.exe$" | % select -first 1 -expand href
  $url64 = $download_page.Links | ? href -match "win64\.exe$" | % select -first 1 -expand href
  if (!$url32 -or !$url64) {
    throw "Either 32-bit or 64-bit url is missing, ignoring for now"
  } else {
    $version = $url -split '/' | select -Last 1 -Skip 1
    @{
      URL32 = "$url32"
      URL64 = "$url64"
      Version = $version
      ReleaseNotes = "$url"
    }
  }
}

try {
update -ChecksumFor none
} catch {
  if ($_ -match 'ignoring for now') { Write-Host "$_"; return 'ignore' }
  else { throw $_ }
}
