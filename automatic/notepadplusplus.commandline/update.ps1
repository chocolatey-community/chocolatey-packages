. $PSScriptRoot\..\notepadplusplus\update.ps1
function global:au_BeforeUpdate {
  $Latest.URL32 = $Latest.URL32_p
  $Latest.URL64 = $Latest.URL64_p
  $Latest.FileType = '7z'
  Get-RemoteFiles -Purge -NoSuffix

  if ($Latest.FileName32.EndsWith('.7z.7z')) {
    $newFileName = [System.IO.Path]::GetFileNameWithoutExtension($Latest.FileName32)
    Move-Item "$PSScriptRoot\tools\$($Latest.FileName32)" "$PSScriptRoot\tools\$newFileName"
    $Latest.FileName32 = $newFileName
  }
  if ($Latest.FileName64.EndsWith('.7z.7z')) {
    $newFileName = [System.IO.Path]::GetFileNameWithoutExtension($Latest.FileName64)
    Move-Item "$PSScriptRoot\tools\$($Latest.FileName64)" "$PSScriptRoot\tools\$newFileName"
    $Latest.FileName64 = $newFileName
  }
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none
}
