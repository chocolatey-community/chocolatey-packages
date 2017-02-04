Import-Module AU

$domain       = 'https://www.magicaljellybean.com'
$releases     = "$domain/keyfinder/"
$softwareName = 'Magical Jelly Bean KeyFinder'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^[$]filePath\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'KeyFinderInstaller\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href
  if ($url32) { $url32 = $domain + $url32 }

  $Matches = $null
  $download_page.Content -match "Installer\s*v([\d\.]+)" | Out-Null
  $version32 = $Matches[1]

  @{
    URL32 = $url32
    Version = $version32
  }
}

update -ChecksumFor none
