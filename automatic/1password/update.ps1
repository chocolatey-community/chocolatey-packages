Import-Module AU
import-module $PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)^(\s*silentArgs\s*=\s*)'.*'"   = "`${1}'$($Latest.SilentArgs)'"
    }
  }
}

function global:au_AfterUpdate {
  . "$PSScriptRoot/update_helper.ps1"
  if ($Latest.PackageName -eq '1password4') {
    removeDependencies ".\*.nuspec"
  }
  else {
    addDependency ".\*.nuspec" 'dotnet4.7.2' '4.7.2.20180712'
  }
}

function global:au_BeforeUpdate {
  if ($Latest.PackageName -eq '1password4') {
    $Latest.SilentArgs = '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`"'
  }
  else {
    $Latest.SilentArgs = '--silent'
  }
}

function Get-LatestOPW {
  param (
    [string]$url,
    [string]$kind

  )

  $url32 = Get-RedirectedUrl $url
  $verRe = '[-]|\.exe$'
  $version = $url32 -split $verRe | select -last 1 -skip 1
  $version = $version -replace ('\.BETA', ' beta')
  $version = Get-Version $version
  $major = $version.ToString(1)

  @{
    URL32       = $url32
    Version     = $version.ToString()
    PackageName = $kind
  }
}

$releases_opw4 = 'https://app-updates.agilebits.com/download/OPW4'
$kind_opw4 = '1password4'
$releases_opw = 'https://app-updates.agilebits.com/download/OPW7/Y'
$kind_opw = '1password'

function global:au_GetLatest {
  $streams = [ordered] @{
    OPW4 = Get-LatestOPW -url $releases_opw4 -kind $kind_opw4
    OPW  = Get-LatestOPW -url $releases_opw -kind $kind_opw
  }

  return @{ Streams = $streams }
}

update -ChecksumFor 32 -IncludeStream $IncludeStream -Force:$Force
