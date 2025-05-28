Import-Module Chocolatey-AU
. "$PSScriptRoot\..\..\automatic\1password\update_helper.ps1"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"                = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function Find-1Password4Stream {
  $releaseUrl = 'https://app-updates.agilebits.com/download/OPW4/Y'

  $result = Get-LatestOPW -url $releaseUrl
  if ($global:au_Version) {
    # There is a small problem with overriding the version in the way we have this implemented.
    # As such we need to set the version explicitly.
    $result['Version'] = $global:au_Version
  } else {
    $result['Version'] = Get-FixVersion -Version $result['Version'] -OnlyFixBelowVersion '4.6.3'
  }
  $result['Readme'] = "$PSScriptRoot\Readme.md"
  $result['DependencyName'] = Split-Path -Leaf $PSScriptRoot

  $result
}

function global:au_GetLatest {
  Find-1Password4Stream
}

# Workaround to ensure to ensure that the fix version will be correctly applied.
$originalForce = $global:au_Force
$global:au_Force = $true
update -ChecksumFor 32
$global:au_Force = $originalForce
