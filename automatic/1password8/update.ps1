Import-Module Chocolatey-AU
. "$PSScriptRoot\..\1password\update_helper.ps1"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function Find-1Password8Stream {
  $releaseUrl = 'https://releases.1password.com/windows/'

  $releasesPage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing

  if ($releasesPage -match 'Updated to (?<version>8\.[\d\.]+) on') {
    $version = Get-Version $Matches['version']
    $url = $releasesPage.Links | Where-Object href -match 'Setup.*\.exe$' | Where-Object href -NotMatch 'BETA' | Select-Object -First 1 -ExpandProperty href
    $url = $url -replace 'LATEST', $version -replace '\.exe$','.msi' # The MSI is documented on: https://support.1password.com/deploy-1password/

    @{
      URL32          = $url
      Version        = $version
      VersionMajor   = $version.ToString(1)
      RemoteVersion  = $version
      Readme         = "$PSScriptRoot\Readme.md"
      DependencyName = Split-Path -Leaf $PSScriptRoot
    }
  } else {
    throw "Unable to find information about 8.x of 1password"
  }
}

function global:au_GetLatest {
  Find-1Password8Stream
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor 32 -IncludeStream $IncludeStream -Force:$Force
}
