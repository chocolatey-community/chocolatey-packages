Import-Module AU

$releases = 'https://www.clementine-player.org/downloads'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge
  $toolsDir = "$PSScriptRoot\tools"
  $fileName = [System.IO.Path]::GetFileName($Latest.FileName32)
  $newFileName = $fileName -replace '_x32',''
  Move-Item "$toolsDir\$($Latest.FileName32)" "$toolsDir\$newFileName"
  $Latest.FileName32 = $newFileName
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]filePath\s*=\s*`"[$]toolsPath\\)[^`"]*`"" = "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re      = '\.exe$'
  $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
  $version = Split-Path (Split-Path $url) -Leaf
  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor none
