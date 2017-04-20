Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://sourceforge.net/projects/scribus/files/scribus/'
$softwareName = 'Scribus*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_AfterUpdate { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(sourceforge *mirror\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\/[\d\.]+\/$'
  $builder = New-Object System.UriBuilder($releases)
  $builder.Path = $download_page.Links | ? href -match $re | select -first 1 -expand href
  $releasesUrl = $builder.Uri.ToString()

  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $re = '\.exe\/download$'
  $urls = $download_page.Links | ? href -match $re | select -expand href

  $url32 = $urls | ? { $_ -notmatch '\-x64' } | select -first 1
  $url64 = $urls | ? { $_ -match '\-x64' } | select -first 1

  $verRe = '\/'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 2

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version32
    ReleasesUrl = $releasesUrl
    FileType = 'exe'
  }
}

update -ChecksumFor none
