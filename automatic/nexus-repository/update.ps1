Import-Module Chocolatey-AU

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease sonatype nexus-public
  $ReleaseVersion = $LatestRelease.tag_name -replace 'release-', ''

  @{
    NexusVersion = $ReleaseVersion
    Version      = $ReleaseVersion -replace '-', '.'
    URL64        = "https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-$($ReleaseVersion)-win64.zip"
  }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]Version\s*=\s*)('.*')"    = "`$1'$($Latest.NexusVersion)'"
      "(^\s*url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

update -ChecksumFor 64
