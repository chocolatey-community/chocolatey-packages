Import-Module AU

$domain   = 'https://sourceforge.net'
$releases = "$domain/projects/pspp4windows/files/"
$softwareName = 'pspp*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

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
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '[\d]{4}\-([\d]{2}\-?){2}\/$'
  $releasesUrl = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }
  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

  $re = '32bits.*\.exe\/download$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $re = '64bits.*\.exe\/download$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href

  $verRe = "PSPPVersion\:\s*pspp-(\d+\.[\d\.]+(-pre2|-))g"
  $download_page.Content -match $verRe | Out-Null
  $version = $Matches[1].TrimEnd('-')

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version
    FileType = 'exe'
  }
}

update -ChecksumFor none
