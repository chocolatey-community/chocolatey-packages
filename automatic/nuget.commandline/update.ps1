Import-Module Chocolatey-AU

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

  $versions = $json."nuget.exe"

  $streams = @{}

  $versions | Sort-Object uploaded -Descending | ForEach-Object {
    $versionTwoPart = $_.version -replace '^(\d+\.\d+).*$', '$1'

    if (!$streams.ContainsKey("$versionTwoPart")) {
      $streams.Add($versionTwoPart, @{
          Version = Get-Version $_.Version
          URL32   = $_.url
        })
    }
  }

  $preKey = $streams.Keys | Where-Object { $_ -match '-' } | Sort-Object -Descending | Select-Object -First 1
  $stableKey = $streams.Keys | Where-Object { $_ -notmatch '-' } | Sort-Object -Descending | Select-Object -First 1
  if ($preKey) {
    $streams.Add('pre', $streams[$preKey])
    $streams.Remove($preKey)
  }
  $streams.Add('stable', $streams[$stableKey])
  $streams.Remove($stableKey)


  return @{ Streams = $streams }
}

update -ChecksumFor none
