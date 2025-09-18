Import-Module Chocolatey-AU

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

    # We are using a semi-hardcoded link here, as we are not ready to move to the MSIX installer.
    # The direct MSI downloads, though not advertised on the download page, are still valid -
    # See: https://support.1password.com/deploy-1password/
    $url = "https://downloads.1password.com/win/1PasswordSetup-$($version).msi"

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
