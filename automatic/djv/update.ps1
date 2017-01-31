Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

# Temporary to allow pushing version 1.0.5
$releases     = 'https://sourceforge.net/projects/djv/files/djv-stable/1.0.5/'
#$releases     = 'http://djv.sourceforge.net/index.html'
$softwareName = 'djv-*'

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $toolsDir = "$PSScriptRoot\tools"
  Remove-Item -Force "$toolsDir\*.exe" -ea 0

  $fileName32 = Get-WebFileName $Latest.URL32 "$($Latest.PackageName)_x86.exe"
  $fileName64 = Get-WebFileName $Latest.URL64 "$($Latest.PackageName)_x64.exe"

  Get-WebFile $Latest.URL32 "$toolsDir\$fileName32"
  Get-WebFile $Latest.URL64 "$toolsDir\$fileName64"

  $Latest.FileName32 = $fileName32
  $Latest.FileName64 = $fileName64

  $Latest.Checksum32 = Get-FileHash "$toolsDir\$fileName32" -Algorithm $Latest.ChecksumType32 | % Hash
  $Latest.Checksum64 = Get-FileHash "$toolsDir\$fileName64" -Algorithm $Latest.ChecksumType32 | % Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^[$]filePath32\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName32)`""
      "(?i)(^[$]filePath64\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '32\.exe\/download$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $re = '64\.exe\/download$'
  $url64 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $verRe = '\/'
  $version = $url64 -split "$verRe" | select -last 1 -skip 2


  @{
    URL32   = $url32
    URL64   = $url64
    Version = $version
  }
}

update -ChecksumFor none
