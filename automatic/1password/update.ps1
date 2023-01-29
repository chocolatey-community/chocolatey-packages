Import-Module AU
import-module $PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"                = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)^(\s*silentArgs\s*=\s*)['`"].*['`"]" = "`${1}`"$($Latest.SilentArgs)`""
    }
  }
}

function global:au_AfterUpdate {
  . "$PSScriptRoot/update_helper.ps1"
  removeDependencies ".\*.nuspec"
  addDependency ".\*.nuspec" "chocolatey-core.extension" "1.3.3"
  if ($Latest.PackageName -eq '1password') {
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

function Get-OPStream {
  param(
    [string]$uri,
    [int]$majorVersion
  )
  switch ($majorVersion) {
    4 {
      $PackageName = "1password4"
      $StreamName = "OPW4"
      $UriParseRegex = "(?<uri>https:.*1Password-(?<version>[0-9.]*)\.((?<prerelease>BETA)-)?(?<buildno>\d+)\.exe)$"
    }
    6 {
      $PackageName = "1password"
      $StreamName = "OPW6"
      $UriParseRegex = "(?<uri>https:.*1PasswordSetup-(?<version>[0-9.]*)([-.](?<prerelease>BETA))?\.exe)$"
    }
    8 {
      $PackageName = "1password"
      $StreamName = "OPW"
      $UriParseRegex = "(?<uri>https:.*1PasswordSetup-(?<version>[0-9.]*)(-((?<buildno>.*)\.)?(?<prerelease>(BETA|NIGHTLY)))?\.exe)$"
    }
  }

  if ($uri -notmatch $UriParseRegex) {
    throw "URI [$uri] did not match Regex for version [$majorVersion]"
  }

  $BaseVersionPart = $Matches.version
  $PrereleasePart = ""
  $BuildPart = ""

  if ($Matches.ContainsKey("buildno")) {
    $BuildPart = ".$($Matches.buildno)"
  }
  if ($Matches.ContainsKey("prerelease")) {
    if ($Matches.prerelease -eq "NIGHTLY") {
      return $null
    }
    $PrereleasePart = "-$($Matches.prerelease)"
    $StreamName += $PrereleasePart
  }

  $Version = (Get-Version ($BaseVersionPart + $BuildPart + $PrereleasePart)).ToString()

  return @{
    Name = $StreamName
    Stream = @{
      URL32 = $uri
      Version = $Version
      PackageName = $PackageName
    }
  }
}

function Update-StreamsWithChecksums {
  param(
    $streams,
    $resultVariable
  )

  foreach ($key in $streams.keys) {
    $previousVersion = (Get-Variable -Scope Global $resultVariable).Value.Streams[$key].NuSpecVersion
    if ( $global:au_Force -or ((Get-Version $streams[$key].Version) -gt (Get-Version $previousVersion))) {
      $Checksum = Get-RemoteChecksum -Url $streams.$key.Url32 -Algorithm "sha256"

      $streams[$key].Checksum32 = $Checksum
      $streams[$key].ChecksumType32 = "sha256"
    }
  }

  return $streams
}

$PackageResultVariableName = "OnePasswordPackage"

function global:au_GetLatest {
  $streams = @{}
  foreach($majorVersion in 4,6,8) {
    $releasesUri = "https://app-updates.agilebits.com/product_history/OPW${majorVersion}"
    $response = Invoke-WebRequest -UseBasicParsing -uri $releasesUri
    $response.Links |
      Where-Object href -match "https://c.1password.com" |
        ForEach-Object {
          $stream = Get-OPStream -uri $_.href -majorVersion $majorVersion
          if (($null -ne $stream) -and !$streams.Contains($stream.Name)) {
            $streams[$stream.Name] = $stream.Stream
          }
        }
  }

  $streams = Update-StreamsWithChecksums $streams $PackageResultVariableName

  return @{ Streams = $streams }
}

update -Result $PackageResultVariableName -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
