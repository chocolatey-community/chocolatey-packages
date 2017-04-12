. $PSScriptRoot\..\putty.install\update.ps1

if ($MyInvocation.InvocationName -ne '.') { # run the update only if the script is not sourced
  function global:au_BeforeUpdate {
    $Latest.FileType = 'zip' # could potentially be overridden from putty.install
    $Latest.URL32 = $Latest.URL32Portable
    $Latest.URL64 = $Latest.URL64Portable
    Get-RemoteFiles -Purge
  }
}

update -ChecksumFor none
