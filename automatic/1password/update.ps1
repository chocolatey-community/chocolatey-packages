[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module AU


function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'" = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_BeforeUpdate {
  . "$PSScriptRoot/update_helper.ps1"
    removeDependencies ".\*.nuspec"
}

function global:au_AfterUpdate {
  . "$PSScriptRoot/update_helper.ps1"
  if ($Latest.PackageName -eq '1password') {
    addDependency ".\*.nuspec" 'dotnet4.6.1' '4.6.01055.20170308'
  } 
}

function global:au_GetLatest {

  $streams = @{}
  $res = @('OPWY';'OPW4';'OPW7')
  $res | % {
    $re = $_
    switch -w ( $re ) {
        'OPW4' {
            $url32 = 'https://app-updates.agilebits.com/download/OPW4'
			$kind = '1password4'
        }
        'OPW7' {
            $url32 = 'https://app-updates.agilebits.com/download/OPW7'
			$kind = '1password'
        }
        'OPWY' {
            $url32 = 'https://app-updates.agilebits.com/download/OPW7/Y'
			$kind = '1password'
        }
    }
    $url32 = Get-RedirectedUrl $url32
    $verRe = '[-]|\.exe$'
    $version = $url32 -split $verRe | select -last 1 -skip 1
    $version = $version -replace('\.BETA',' beta')
    $version = Get-Version $version
    $major = $version.ToString(1)

    if (!($streams.ContainsKey($kind))) {
      $streams.Add($re, @{
        URL32 = $url32
        Version = $version.ToString()
        PackageName = $kind
      })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor 32 -IncludeStream $IncludeStream -Force:$Force
