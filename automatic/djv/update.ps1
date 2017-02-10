Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

# Temporary to allow pushing version 1.0.5
$releases     = 'http://djv.sourceforge.net/index.html'
$softwareName = 'djv-*'

function global:au_BeforeUpdate {
  $Latest.ChecksumType64 = 'sha256'
  $toolsDir = "$PSScriptRoot\tools"
  Remove-Item -Force "$toolsDir\*.exe" -ea 0

  $fileName64 = Get-WebFileName $Latest.URL64 "$($Latest.PackageName).exe"

  Get-WebFile $Latest.URL64 "$toolsDir\$fileName64"

  $Latest.FileName64 = $fileName64

  $Latest.Checksum64 = Get-FileHash "$toolsDir\$fileName64" -Algorithm $Latest.ChecksumType64 | % Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..*)\<.*\>"              = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(`"[$]toolsPath\\)[^`"]*`""    = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '64\.exe\/download$'
  $url64 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $verRe = '\/'
  $version = $url64 -split "$verRe" | select -last 1 -skip 2


  @{
    URL64   = $url64
    Version = $version
  }
}

update -ChecksumFor none
