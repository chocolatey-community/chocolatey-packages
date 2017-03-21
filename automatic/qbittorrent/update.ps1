import-module au
Import-Module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

$releases = 'http://www.qbittorrent.org/download.php'

function global:au_BeforeUpdate {
  # We can't get Get-RemoteFiles because we use sourceforge
  #Get-RemoteFiles -Purge -FileNameBase $Latest.PackageName

  function Download-File($url, $defaultName) {
    $fileName = Get-WebFileName $url $defaultName
    $toolsDir = "$PSScriptRoot\tools"

    Get-WebFile $url "$toolsDir\$fileName"

    $checksum = Get-FileHash "$toolsDir\$fileName" -Algorithm SHA256 | % Hash
    @{ FileName = $fileName ; Checksum = $checksum }
  }

  $result32 = Download-File -url $Latest.URL32 "qbittorrent_x86.exe"
  $result64 = Download-File -url $Latest.URL64 "qbittorrent_x64.exe"

  $Latest.ChecksumType = 'sha256'
  $Latest.FileName32   = $result32.FileName
  $Latest.Checksum32   = $result32.Checksum
  $Latest.FileName64   = $result64.FileName
  $Latest.Checksum64   = $result64.Checksum
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(\s;\s*)'.*'(\s*# 32\-bit)" = "`${1}'$($Latest.FileName32)'`${2}"
      "(?i)(\s;\s*)'.*'(\s*# 64\-bit)" = "`${1}'$($Latest.FileName64)'`${2}"
    }
    ".\tools\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re    = 'setup\.exe\/download$'
  $urls  = $download_page.links | ? href -match $re | select -First 2 -expand href
  $url32 = $urls | ? { $_ -notmatch "x64" }  | select -first 1
  $url64 = $urls | ? { $_ -match "x64" } | select -first 1

  $version   = $url32 -split '[_]' | select -Last 1 -Skip 1
  $version64 = $url64 -split '[_]' | select -Last 1 -Skip 2

  if ($version -ne $version64) {
    throw "32-bit and 64-bit version do not match. Please investigate."
  }

  return @{
    URL32 = $url32
    URL64 = $url64
    Version = $version
  }
}

update -ChecksumFor none
