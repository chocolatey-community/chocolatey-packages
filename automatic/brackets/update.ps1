import-module au

$releases = 'https://github.com/adobe/brackets/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '[\d\.]+\.msi$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { 'https://github.com' + $_ }
  if (!$url32) { Write-Host 'No Windows release is avaialble'; return 'ignore' }

  $verRe = "release\-|\/"
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  @{
    URL32 = $url32
    Version = $version32
    PackageName = 'Brackets'
  }
}

update -ChecksumFor none
