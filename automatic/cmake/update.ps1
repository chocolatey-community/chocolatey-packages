[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module Chocolatey-AU

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

  $allMsis = $download_page.Links | Where-Object href -match '\.msi$' | Select-Object -expand href
  $allZips = $download_page.Links | Where-Object href -match '\.zip$' | Select-Object -expand href

  $streams = @{ }

  $re32 = '(win32\-x86|windows-i386)'
  $re64 = '(win64-x64|windows-x86_64)'

  $allMsis | Where-Object { $_ -match "\-x86.m|\-i386.m" } | ForEach-Object {
    $version = ($_ -split '\/' | Select-Object -last 1 -skip 1).TrimStart('v')
    $url64 = $allMsis | Where-Object { $_ -match "$version-$re64" }
    $versionTwopart = $version -replace '^([\d]+\.[\d]+).*$', '$1'

    $url32_portable = $allZips | Where-Object { $_ -match "$version-$re32" }
    $url64_portable = $allZips | Where-Object { $_ -match "$version-$re64" }

    if ($streams.ContainsKey($versionTwoPart)) {
        $previousKeyVersion = Get-Version $streams[$versionTwoPart].Version
        $currentKeyVersion = Get-Version $version
        if ($currentKeyVersion -gt $previousKeyVersion) {
            $streams[$versionTwopart] = @{
                Version = $version
                URL32_i = [uri]$_
                URL64_i = [uri]$url64
                URL32_p = [uri]$url32_portable
                URL64_p = [uri]$url64_portable
            }
        }
    } else {
        $streams.Add($versionTwopart, @{
            Version = $version
            URL32_i = [uri]$_
            URL64_i = [uri]$url64
            URL32_p = [uri]$url32_portable
            URL64_p = [uri]$url64_portable
          })
    }
  }

  return @{ Streams = $streams }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none -IncludeStream $includeStream -Force:$Force
}
