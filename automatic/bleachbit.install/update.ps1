. "$PSScriptRoot\..\bleachbit\update.ps1"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(type:).*"       = "`${1} $($Latest.ChecksumType32)"
    }
  }
}

update -ChecksumFor none
