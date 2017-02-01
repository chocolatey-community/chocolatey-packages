import-module au

$releases = "http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html"

if ($MyInvocation.InvocationName -ne '.') { # run the update only if the script is not sourced
  function global:au_BeforeUpdate {
    Remove-Item "$PSScriptRoot\tools\*.msi"

    $client = New-Object System.Net.WebClient
    try
    {
      $filePath32 = "$PSScriptRoot\tools\$($Latest.FileName32)"
      $client.DownloadFile($Latest.URL32, "$filePath32")
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
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType)"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum)"
    }
    'tools\chocolateyInstall.ps1' = @{
      "(PackageName\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.PackageName)`""
      "(^[$]filePath\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  #https://the.earth.li/~sgtatham/putty/latest/x86/putty-0.67-installer.msi
  $reInstaller  = "putty-(.+)-installer.msi"
  $url32 = $download_page.links | Where-Object href -match $reInstaller | Select-Object -First 1 -expand href
  $version = $matches[1] 

  $filename32 = [IO.Path]::GetFileName($url32)

  return @{
    URL32 = $url32
    FileName32 = $filename32
    Version = $version
  }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update -ChecksumFor none
}
