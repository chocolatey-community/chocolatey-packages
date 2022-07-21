[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module AU

$changelogs = 'https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/README.md'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>"   = "`${1}<$($Latest.ReleaseNotes)>"
      "(?i)(^\s*32\-bit software.*)\<.*\>"  = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*64\-bit software.*)\<.*\>"  = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"       = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"         = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
    # Only report the supported Kubernetes streams.
    # NB Upstream Kubernetes only supports the last three minor versions.
    #    However, they can also do pre-releases before a final version is
    #    released, so we have to check for an extra changelogs/minor
    #    version to be able to find all the supported streams.
    # See https://github.com/kubernetes/sig-release/blob/master/release-engineering/versioning.md
    $minor_versions_to_keep = 3

    $changelog_page = Invoke-WebRequest -Uri $changelogs -UseBasicParsing
    $minor_version_changelogs = $changelog_page.links `
      | Where-Object href -match "CHANGELOG-(?<version>\d+\.\d+)\.md`$" `
      | Select-Object -Expand href -First ($minor_versions_to_keep+1)

    $streams = @{}

    $minor_version_changelogs | ForEach-Object {
        if ($_ -notmatch "CHANGELOG-(?<version>\d+\.\d+)\.md`$") {
          return
        }
        $minor_version = $matches.version
        if ($streams.ContainsKey($minor_version)) {
          return
        }
        $minor_changelog_page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com$_"
        $url64 = $minor_changelog_page.links `
          | Where-Object href -match "/v(?<version>\d+(\.\d+)+)/kubernetes-client-windows-amd64.tar.gz" `
          | Select-Object -First 1 -Expand href
        $patch_version = $matches.version
        if (!$url64) {
          return
        }
        $url32 = $minor_changelog_page.links `
          | Where-Object href -match "/v(?<version>\d+(\.\d+)+)/kubernetes-client-windows-386.tar.gz" `
          | Select-Object -First 1 -Expand href

        $streams.Add($minor_version, @{
            Version     = $patch_version
            URL32       = $url32
            URL64       = $url64
            ReleaseNotes= "https://github.com$_"
        })
    }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
