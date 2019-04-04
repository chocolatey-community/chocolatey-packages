import-module au

$releases = "https://dist.nuget.org/tools.json"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s*download the.*)<.*>"   = "`$1<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"   = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $json = Invoke-WebRequest -UseBasicParsing -Uri $releases | ConvertFrom-Json

  $versions = $json."nuget.exe" | Sort-Object uploaded -Descending
  $preRelease = $versions | ? stage -EQ 'EarlyAccessPreview' | select -First 1
  $stableRelease46 = $versions | ? stage -EQ 'ReleasedAndBlessed' | ? version -like '4.6.*' | select -First 1
  $stableRelease47 = $versions | ? stage -EQ 'ReleasedAndBlessed' | ? version -like '4.7.*' | select -First 1
  $stableRelease48 = $versions | ? stage -EQ 'ReleasedAndBlessed' | ? version -like '4.8.*' | select -First 1
  $stableRelease49 = $versions | ? stage -EQ 'ReleasedAndBlessed' | ? version -like '4.9.*' | select -First 1
  $stableRelease = $versions | ? stage -EQ 'ReleasedAndBlessed' | select -First 1

  $streams = @{
    'pre'    = @{
      Version = $preRelease.version
      URL32   = $preRelease.url
    }
    'stable46' = @{
      Version = $stableRelease46.version
      URL32   = $stableRelease46.url
    }
    'stable47' = @{
      Version = $stableRelease47.version
      URL32   = $stableRelease47.url
    }
    'stable48' = @{
      Version = $stableRelease48.version
      URL32   = $stableRelease48.url
    }
    'stable49' = @{
      Version = $stableRelease49.version
      URL32   = $stableRelease49.url
    }
    'stable' = @{
      Version = $stableRelease.version
      URL32   = $stableRelease.url
    }
  }


  return @{ Streams = $streams }
}

update -ChecksumFor none
