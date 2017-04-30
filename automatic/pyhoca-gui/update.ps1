Import-Module AU
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases     = 'http://code.x2go.org/releases/binary-win32/pyhoca-gui/releases/'
$softwareName = 'PyHoca-GUI'
$padVersionUnder = '0.5.1'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -Algorithm sha256

  if ($Latest.VerifyChecksum32 -ne $Latest.Checksum32) {
    throw "The checksum of the downloaded file does not match the upstream checksum"
  }
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*located at\:?\s*)\<.*\>" = "`${1}<$($Latest.VersionReleaseUrl)>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^[$]filePath\s*=\s*`"[$]toolsPath\\)[^`"]*`"" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'" = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"      = "`${1}'$softwareName'"
    }
    ".\tools\install.ahk"             = @{
      "(?i)(ahk_exe)[^,]*," = "`${1} $($Latest.FileName32),"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $versionDir = $download_page.Links | ? href -Match "^[\d\.]+(-[\d]+)?\/$" | sort -Descending -Property href | select -expand href -first 1
  $version32 = $versionDir -split '[\/\-]' | select -first 1

  $download_page = Invoke-WebRequest -uri ($releases + $versionDir) -UseBasicParsing

  $fileName = $download_page.Links | ? href -match "^PyHoca\-GUI.*\.exe$" | select -first 1 -expand href

  $url32 = $releases + $versionDir + $fileName

  $download_page = Invoke-WebRequest -Uri ($url32 + '.sha256') -UseBasicParsing

  $checksum32 = $download_page -split ' ' | select -first 1

  @{
    URL32 = $url32
    Version = Get-PaddedVersion $version32 $padVersionUnder -RevisionLength 4
    VerifyChecksum32 = $checksum32
    VersionReleaseUrl = $releases + $versionDir
  }
}

update -ChecksumFor none
