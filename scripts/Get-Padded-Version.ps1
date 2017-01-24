<#
.SYNOPSIS
  Pad the revision number if the passed version is using a 4-part version scheme.

.DESCRIPTION
  Adds padded zeroes to the revision part of the version if the passed
  Version parameter is using a 4-part scheme and the Parameter OnlyBelowVersion
  is either $null or greater than the Version parameter.

.PARAMETER Version
  The version number to add the revision padding to (Pre-Releases is not supported).

.PARAMETER OnlyBelowVersion
  Only add padded zeroes to a Version when it is below this parameter, or always
  add padded zeroes if this parameter is $null.

.PARAMETER RevisionLength
  The total length of the revision number part

.OUTPUTS
  The full padded version, or the specified Version if padding was not needed.

.EXAMPLE
  Get-Padded-Version -Version '24.0.0.195'
  will output '24.0.0.195000' if the nuspec version is less than the version

.EXAMPLE
  Get-Padded-Version -Version '24.0.0.195'
  will output '24.0.0.195001' if the nuspec version is equal to '24.0.0.195'
  or equal to '24.0.0.195000'

.EXAMPLE
  Get-Padded-Version -Version '24.0.1.2' -OnlyBelowVersion '24.0.1'
  Will output the same version that was given without padded zeroes.
#>

function Get-Padded-Version() {
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Version,
    [Parameter(Position = 1)]
    [version]$OnlyBelowVersion = $null,
    [int]$RevisionLength = 6
  )

  if ($Version -match "^([\d]+\.){1,2}[\d]+$") {
    Write-Debug "There is no need to pad the version information"
    return $Version
  } elseif ($Version -notmatch "^[\d\.]+$") {
    Write-Warning "Padding of pre release versions is not supported";
    return $Version
  }

  $Matches = $null

  if ($OnlyBelowVersion -ne $null -and ([version]$Version) -ge $OnlyBelowVersion) {
    Write-Debug "Version is greater than or equal to $OnlyBelowVersion, no need to pad revision version."
    return $Version;
  }

  $versionInfo = [version]$Version
  $revision = $versionInfo.Revision
  $paddedRev = [int]($revision.ToString().PadRight($RevisionLength, '0'));

  if ($global:au_force -eq $true) {
    Write-Debug "Loading nuspec file to see if we need to pad the version"
    $content = gc -Encoding UTF8 (Resolve-Path "*.nuspec");
    $content | ? { $_ -match "\<version\>([\d\.]+)\<\/version\>" } | Out-Null
    if ($Matches) {
      $newVersion = [version]$Matches[1]
      $paddedNewRev = [int]$newVersion.Revision.ToString().PadRight($RevisionLength, '0')
      while ($paddedRev -le $paddedNewRev) {
        $paddedRev++ | Out-Null
      }
    }
  }

  return $versionInfo.ToString() -replace '^([\d]+\.[\d]+\.[\d]+\.)\d+$',"`${1}$paddedRev"
}
