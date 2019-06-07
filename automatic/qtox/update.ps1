import-module au

$releases = "https://github.com/qTox/qTox/releases"
$softwareName = 'qTox'

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

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase "setup-$($softwareName)-$($Latest.Version)" }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re      = '\.exe$'
  $domain  = $releases -split '(?<=//.+)/' | select -First 1
  $url     = $download_page.links | ? href -match $re | select -First 2 -Expand href | % { $domain + $_ }
  $version = $url[0] -split '/' | select -Last 1 -Skip 1

  @{
    URL32    = $url -notmatch '_64-' | select -First 1
    URL64    = $url -match '_64-'    | select -First 1
    Version  = $version.Substring(1)    
  }
}

update -ChecksumFor none
