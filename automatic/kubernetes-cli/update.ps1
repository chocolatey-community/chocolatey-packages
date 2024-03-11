[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module Chocolatey-AU

$changelogs = 'https://raw.githubusercontent.com/kubernetes/kubernetes/master/CHANGELOG/README.md'

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

    $changelogs = (Invoke-WebRequest -Uri $changelogs -UseBasicParsing).content

    # There is quite a few versions that do not exist on chocolatey.org
    # and since the limit of pushed packages is 10, we need to limit the amount
    # of streams that we parse. Once packages are approved we can increase/remove
    # the limit.
    $minor_version_changelogs = $changelogs `
      | Select-String -Pattern "- \[CHANGELOG-(?<version>\d\.\d+)\.md\]" -AllMatches `
      | ForEach-Object {$_.Matches.Groups.Where{$_.Name -eq 'version'}.value} `
      | Select-Object -First 10

    $streams = @{}

    foreach ($minor_version in $minor_version_changelogs) {
        if ($streams.ContainsKey($minor_version)) {
          return
        }

        $minor_changelog_page = Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/kubernetes/kubernetes/master/CHANGELOG/CHANGELOG-$($minor_version).md"
        $url64 = $minor_changelog_page.content `
          | Select-String -Pattern "(?<=\[.+\]\()(?<href>.+/v(?<version>\d+(\.\d+)+)/kubernetes-client-windows-amd64\.tar\.gz)\)" `
          | ForEach-Object {$_.Matches.Groups.Where{$_.Name -eq 'href'}.value} `
          | Select-Object -First 1

        if (!$url64) {
          return
        }

        if ($url64 -match "/v(?<version>\d+(\.\d+)+)/kubernetes-client-windows-amd64.tar.gz") {
          $patch_version = $matches.version
        }

        $url32 = $minor_changelog_page.content `
          | Select-String -Pattern "(?<=\[.+\]\()(?<href>.+/v(?<version>\d+(\.\d+)+)/kubernetes-client-windows-386\.tar\.gz)\)" `
          | ForEach-Object {$_.Matches.Groups.Where{$_.Name -eq 'href'}.value} `
          | Select-Object -First 1

        $streams.Add(
          $minor_version,
          @{
            Version      = $patch_version
            URL32        = $url32
            URL64        = $url64
            ReleaseNotes = "https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-$($minor_version).md"
          }
        )
    }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
