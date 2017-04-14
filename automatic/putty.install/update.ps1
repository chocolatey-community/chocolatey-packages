. $PSScriptRoot\..\putty\update.ps1

if ($MyInvocation.InvocationName -ne '.') { # run the BeforeUpdate function only if the script is not sourced
  function global:au_BeforeUpdate {
    $Latest.FileType = 'msi' # could potentially be overridden from putty.portable
    $Latest.URL32 = $Latest.URL32Installer
    $Latest.URL64 = $Latest.URL64Installer
    Get-RemoteFiles -Purge -NoSuffix
  }
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>"  = "`${1}<$releases>"
      "(?i)(32-Bit.+)\<.*\>"      = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>"      = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum32:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*"       = "`${1} $($Latest.Checksum64)"
    }
    'tools\chocolateyInstall.ps1' = @{
      "(PackageName\s*=\s*)`"([^*]+)`""               = "`$1`"$($Latest.PackageName)`""
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\)(.*)`""   = "`$1$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName64)`""
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update -ChecksumFor none
}
