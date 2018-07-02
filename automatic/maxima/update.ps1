Import-Module AU

$releases = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows'
$softwareName = 'maxima*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"         = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '[\d\.]+\-Windows\/$'
  $releasesUrl = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { 'https://sourceforge.net' + $_ }
  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

  $re = 'win32\.exe\/download$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $re = 'win64\.exe\/download$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href

  $verRe = '-'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  $version64 = $url64 -split "$verRe" | select -last 1 -skip 1
  if ($version32 -ne $version64) {
    throw "32bit version do not match the 64bit version"
  }
  if ($version32 -match '[a-z]$') {
    [char]$letter = $version32[$version32.Length - 1]
    [int]$num = $letter - [char]'a'
    $num++
    $version32 = $version32 -replace $letter, ".$num"
  }

  $versionTwoPart = $version32 -replace '^(\d+\.\d+)\.[\d\.]+$',"`$1"


  @{
    URL32        = $url32
    URL64        = $url64
    Version      = $version32
    ReleaseNotes = "https://sourceforge.net/p/maxima/code/ci/master/tree/ChangeLog-$($versionTwoPart).md"
    FileType     = 'exe'
  }
}

update -ChecksumFor none
