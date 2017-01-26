Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$domain       = 'https://www.tipp10.com'
$releases     = "$domain/en/download/"
$softwareName = 'Tipp10*'

function global:au_BeforeUpdate {
  $Latest.FileName32 = 'tipp10.exe'
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName32)"
  Get-WebFile $Latest.URL32 $filePath

  $Latest.Checksum32 = Get-FileHash $filePath -Algorithm 'SHA256' | % Hash
  $Latest.ChecksumType32 = 'sha256'
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*1\..+)\<.*\>"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"   = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"    = "`${1}'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)'.*'"   = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\)[^`"]*`"" = "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $version_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version32 = $version_page.Content | ? { $_ -match 'Version ([\d\.]+)'} | select -first 1
  if ($version32 -and $Matches) {
    $version32 = $Matches[1]
  } else {
    throw "Unable to get version information"
  }

  $url32 = $version_page.links | ? href -match 'getfile\/0\/?$' | select -first 1 -expand href
  $download_page = Invoke-WebRequest -Uri ($domain + $url32) -UseBasicParsing

  $re = '\/download\/getfile'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href
  @{
    URL32   = $domain + $url32
    Version = $version32
  }
}

update -ChecksumFor none
