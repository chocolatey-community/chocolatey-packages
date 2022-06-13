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
    $changelog_page = Invoke-WebRequest -Uri $changelogs -UseBasicParsing
    #Only the latest three minor versions are supported: https://github.com/kubernetes/sig-release/blob/master/release-engineering/versioning.md
    #However, there are prereleases before the version is released, so the latest four changelogs/minor versions need to be checked.
    $minor_version_changelogs = $changelog_page.links | ? href -match "CHANGELOG-[\d\.]+\.md" | Select-Object -Expand href -First 4
    
    $streams = @{}
    
    $minor_version_changelogs | ForEach-Object {
        $minor_version = ($_ -split "CHANGELOG-" | Select-Object -Last 1).trim(".md")
        $minor_changelog_page = Invoke-WebRequest -UseBasicParsing -Uri ("https://github.com" + $_)
        $url64 = $minor_changelog_page.links | ? href -match "/v(?<version>[\d\.]+)/kubernetes-client-windows-amd64.tar.gz" | Select-Object -First 1 -Expand href
        $patch_version = $matches.version
        $url32 = $minor_changelog_page.links | ? href -match "/v[\d\.]+/kubernetes-client-windows-386.tar.gz" | Select-Object -First 1 -Expand href
        
        $streams.Add($minor_version, @{
            Version     = $patch_version
            URL32       = $url32
            URL64       = $url64
            ReleaseNotes= ("https://github.com" + $_)
        })
    }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
