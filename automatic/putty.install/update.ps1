. $PSScriptRoot\..\putty\update.ps1

if ($MyInvocation.InvocationName -ne '.') { # run the update only if the script is not sourced
  function global:au_BeforeUpdate {
    Remove-Item "$PSScriptRoot\tools\*.msi"

    $client = New-Object System.Net.WebClient
    try
    {
      $filePath32 = "$PSScriptRoot\tools\$($Latest.FileName32Installer)"
      $client.DownloadFile($Latest.URL32Installer, "$filePath32")
    }
    finally
    {
      $client.Dispose()
    }

    $Latest.ChecksumType = "sha256"
    $Latest.Checksum32 = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath32 | ForEach-Object Hash
  }
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL32Installer)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType)"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum)"
    }
    'tools\chocolateyInstall.ps1' = @{
      "(PackageName\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.PackageName)`""
      "(^[$]filePath\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName32Installer)`""
    }
  }
}

update -ChecksumFor none
