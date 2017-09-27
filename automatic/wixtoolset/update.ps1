Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

#$redirectPage = 'http://wixtoolset.org/releases/v3-10-3-3007/' # Provided in case we need to update the latest stable
$releases = 'http://wixtoolset.org/releases/'
$softwareName = 'WiX Toolset*'
$padUnderVersion = '3.10.4'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*located at\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {

  $builder = New-Object System.UriBuilder($releases)
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $re = '(rc[\d]+|stable)$'
  $builder.Path  = $download_page.Links | ? href -match $re | select -first 1 -expand href
  $redirectPage = Get-RedirectedUrl $builder.ToString()
  $preReleaseSuffix = if ($builder.Path.EndsWith('stable')) { '' }
    else {
      $index = $builder.Path.IndexOf('rc')
      "-" + $builder.Path.Substring($index)
    }

  $downloadBuilder = New-Object System.UriBuilder($redirectPage)
  $download_page = Invoke-WebRequest -Uri $redirectPage -UseBasicParsing
  $downloadBuilder.Path = $download_page.Links | ? href -match "\.exe$" | select -first 1 -expand href

  $verRe = '\/v?'
  $version32 = ($builder.Path -split "$verRe" | select -last 1 -skip 1) -replace '\-','.'
  if ($preReleaseSuffix) { $version32 += $preReleaseSuffix }

  @{
    URL32 = $downloadBuilder.Uri.ToString()
    Version = $version32
    ReleasesUrl = $redirectPage
  }
}

update -ChecksumFor none
