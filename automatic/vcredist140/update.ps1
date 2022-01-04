Import-Module AU
Import-Module Wormies-AU-Helpers
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\scripts/au_extensions.psm1"

$channels = @(
  @{ VSMajor = 17; VSYear = 2022; IsPrerelease = $false }
  @{ VSMajor = 16; VSYear = 2019; IsPrerelease = $false }
  @{ VSMajor = 15; VSYear = 2017; IsPrerelease = $false }
)

function global:au_SearchReplace {
  @{
    ".\vcredist140.nuspec" = @{
      'Visual Studio \d+-\d+'                               = $Latest.VSRange
    }
    ".\tools\data.ps1" = @{
      "^(?i)(\s*Url\s*=\s*)'.*'"                            = "`$1'$($Latest.URL32)'"
      "^(?i)(\s*Checksum\s*=\s*)'.*'"                       = "`$1'$($Latest.Checksum32)'"
      "^(?i)(\s*ChecksumType\s*=\s*)'.*'"                   = "`$1'$($Latest.ChecksumType32)'"
      "^(?i)(\s*Url64\s*=\s*)'.*'"                          = "`$1'$($Latest.URL64)'"
      "^(?i)(\s*Checksum64\s*=\s*)'.*'"                     = "`$1'$($Latest.Checksum64)'"
      "^(?i)(\s*ChecksumType64\s*=\s*)'.*'"                 = "`$1'$($Latest.ChecksumType64)'"
      "^(?i)(\s*ThreePartVersion\s*=\s*\[version\]\s*)'.*'" = "`$1'$($Latest.VersionThreePart)'"
      "^(?i)(\s*SoftwareName\s*=\s*)'.*'"                   = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function Get-RemoteChecksumFast([string] $Url, $Algorithm='sha256', $Headers)
{
    $ProgressPreference = 'SilentlyContinue'
    & (Get-Command -Name Get-RemoteChecksum).ScriptBlock.GetNewClosure() @PSBoundParameters
}

function GetResultInformation([string]$url32, [string]$url64) {
  $url32 = Get-RedirectedUrl $url32
  $url64 = Get-RedirectedUrl $url64
  $dest = "$env:TEMP\vcredist140.exe"

  Get-WebFile $url32 $dest | Out-Null
  $checksumType = 'sha256'
  $version = Get-Version (Get-Item $dest | % { $_.VersionInfo.ProductVersion })
  $checksum32 = Get-FileHash $dest -Algorithm $checksumType | % { $_.Hash.ToLowerInvariant() }

  return @{
    URL32            = $url32
    URL64            = $url64
    Version          = if ($version.Version.Revision -eq '0') { $version.ToString(3) } else { $version.ToString() }
    VersionThreePart = $version.ToString(3)
    Checksum32       = $checksum32
    ChecksumType32   = $checksumType
    Checksum64       = Get-RemoteChecksumFast $url64 -Algorithm $checksumType
    ChecksumType64   = $checksumType
  }
}

function global:au_GetLatest {
  $latestInfo = @{
    Streams = [ordered]@{
    }
  }

  foreach ($channelInfo in $channels) {
    $streamName = $channelInfo.VSMajor.ToString()
    $x64Release = 'https://aka.ms/vs/{0}/release/VC_redist.x64.exe' -f $channelInfo.VSMajor
    $x86Release = 'https://aka.ms/vs/{0}/release/VC_redist.x86.exe' -f $channelInfo.VSMajor

    $channelLatestInfo = Update-OnETagChanged `
      -execUrl $x64Release `
      -saveFile ('.\info-{0}.txt' -f $streamName) `
      -OnEtagChanged { GetResultInformation $x86Release $x64Release } `
      -OnUpdated { GetResultInformation $x86Release $x64Release }

    $channelLatestInfo['VSRange'] = 'Visual Studio 2015-{0}' -f $channelInfo.VSYear
    $channelLatestInfo['SoftwareName'] = 'Microsoft Visual C++ 2015-{0} Redistributable*' -f $channelInfo.VSYear
    if ($channelInfo.IsPrerelease) {
      if ($channelLatestInfo['Version'] -like '*-*') {
        throw ('Latest version determined for channel {0} already has the prerelease suffix. This is unexpected.' -f $channelInfo.VSMajor)
      }
      $channelLatestInfo['Version'] = $channelLatestInfo['Version'] + '-prerelease'
    }

    Write-Verbose "Stream: $streamName latest: $($channelLatestInfo['Version'])"
    $latestInfo.Streams.Add($streamName, $channelLatestInfo)
  }

  $latestInfo | ConvertTo-Json -Depth 10 | Out-String | Write-Debug

  return $latestInfo
}

update -ChecksumFor none
