import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain = 'https://sourceforge.net'
$releases = "$domain/projects/gnucash/files/gnucash%20%28stable%29/"
$softwareName = 'GnuCash*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
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
      "(?i)^(\s*softwareName\s*=\s*)'.*'"       = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  # First let us get the folder that contains the executables
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url = $download_page.Links | ? href -match "[\d\.]+\/$" | select -First 1 -expand href | % { $domain + $_ }

  # Then get the executable

  $download_page = Invoke-WebRequest -Uri $url -UseBasicParsing

  $re = '\.exe\/download$'
  $url = $download_page.links | ? href -match $re | select -first 1 -expand href | % { if ($_.StartsWith('/')) { $domain + $_ } else { $_ } }

  $version = $url -split '[-]' | select -Last 1 -Skip 1

  @{
    URL32    = $url
    Version  = $version
    FileType = 'exe'
  }
}

update -ChecksumFor none
