[CmdletBinding()]
param($IncludeStream,[switch]$Force)
Import-Module AU

$releases = 'https://cmake.org/download/'

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $allMsis = $download_page.Links | ? href -match '\.msi$' | select -expand href | % { "https://cmake.org" + $_ }
  $allZips = $download_page.Links | ? href -match '\.zip$' | select -expand href | % { "https://cmake.org" + $_ }

  $streams = @{ }

  $allMsis | ? { $_ -match '\-x86' } | % {
    $version = $_ -split 'cmake\-|\-win32' | select -last 1 -skip 1
    $url64 = $allMsis | ? { $_ -match "$version-win64\-x64" }
    $versionTwopart = $version -replace '^([\d]+\.[\d]+).*$','$1'

    $streams.Add($versionTwopart, @{
      Version = $version
      URL32_i = [uri]$_
      URL64_i = [uri]$url64
      URL32_p = [uri]($allZips | ? { $_ -match "$version-win32\-x86" })
      URL64_p = [uri]($allZips | ? { $_ -match "$version-win64\-x64" })
    })
  }

  return @{ Streams = $streams }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none -IncludeStream $includeStream -Force:$Force
}
