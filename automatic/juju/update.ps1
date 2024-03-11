[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module Chocolatey-AU

$releases = 'https://launchpad.net/juju/+download'
$ghReleasesFmt = 'https://github.com/juju/juju/releases/tag/juju-{0}'

function global:au_BeforeUpdate() { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName32)`""
    }
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(1\..+)\<.*\>"      = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum:).*"      = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_AfterUpdate() {
  $release_page = Invoke-WebRequest -Uri ($ghReleasesFmt -f $($Latest.RemoteVersion)) -UseBasicParsing

  $release_notes = $release_page.Links | Where-Object href -match "release-notes|roadmap-releases" | Select-Object -First 1 -expand href

  if ($release_page -and -not $release_notes) {
    Write-Warning "Release notes not found within body of the GitHub release. Linking directly to release."
    $release_notes = $ghReleasesFmt -f $($Latest.RemoteVersion)
  }

  if ($release_notes) {
    Update-Metadata -key "releaseNotes" -value $release_notes
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re = '\.exe$'
  $urls = $download_page.links | Where-Object href -match $re | Select-Object -expand href

  $streams = @{}

  $urls | ForEach-Object {
    $versionArr = $_ -split 'setup[-]|[-]signed|.exe'
    if ($versionArr[1]) {
      $version = Get-Version $versionArr[1]
    }
    else {
      $version = Get-Version $versionArr[0]
    }

    if (!$streams.ContainsKey($version.ToString(2))) {
      $streams.Add($version.ToString(2), @{ URL32 = $_ ; Version = $version.ToString(); RemoteVersion = $version.ToString() })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
