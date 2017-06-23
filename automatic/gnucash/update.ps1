import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain       = 'https://github.com'
$releases     = "$domain/Gnucash/gnucash/releases/latest"
$softwareName = 'GnuCash*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_AfterUpdate {
  Set-DescriptionFromReadme -SkipFirst 1
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re    = '^/.+\.exe$'
  $url   = $download_page.links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }

  $version  = $url -split '\/' | select -Last 1 -Skip 1

  if (!($version -match "^[\d\.]+$")) {
    # They changed the filename again, lets try the tag name
    $version = ($url -split '\/' | select -last 1 -skip 1)
  }

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor none
