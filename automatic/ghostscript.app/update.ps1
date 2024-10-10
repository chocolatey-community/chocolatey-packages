Import-Module Chocolatey-AU
. "$PSScriptRoot\..\Ghostscript\update.ps1"

$softwareName = 'GPL Ghostscript'

function global:au_BeforeUpdate {
  $Latest.PackageName = 'Ghostscript.app'
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  [version]$version = $Latest.RemoteVersion
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^[$]filePath32\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName32)`""
      "(?i)(^[$]filePath64\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

update -ChecksumFor none
