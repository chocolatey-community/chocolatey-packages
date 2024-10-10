[CmdletBinding()]
param([switch] $Force)

Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameBase "openshift-origin-client-tools"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseURL)`${2}"
    }
  }
}

function global:au_GetLatest {
  $StableReleaseUrl = "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/release.txt"
  $LatestVersion = if ((Invoke-WebRequest -Uri $StableReleaseUrl -UseBasicParsing).Content -match "Version:\s+(?<Version>.+)") {
    $Matches.Version
  } else {
    Write-Error "Could not identify latest version from '$StableReleaseUrl'" -ErrorAction Stop
  }

  # We could get the SHA256 value from /sha256sum.txt in the same directory, but we currently generate it

  return @{
    Version    = $LatestVersion
    URL64      = "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$LatestVersion/openshift-client-windows-$LatestVersion.zip"
    ReleaseURL = "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$LatestVersion"
  }
}

update -ChecksumFor none -Force:$Force
