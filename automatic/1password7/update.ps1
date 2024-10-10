Import-Module Chocolatey-AU
. "$PSScriptRoot\..\1password\update_helper.ps1"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"                = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function Find-1Password7Stream {
  $releaseUrl = 'https://app-updates.agilebits.com/download/OPW7/Y'

  $result = Get-LatestOPW -url $releaseUrl
  $result['Readme'] = "$PSScriptRoot\Readme.md"
  $result['DependencyName'] = Split-Path -Leaf $PSScriptRoot

  $result
}

function global:au_GetLatest {
  Find-1Password7Stream
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor 32 -IncludeStream $IncludeStream -Force:$Force
}
