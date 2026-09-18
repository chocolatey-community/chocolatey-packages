[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module Chocolatey-AU

$seriesUri = 'https://api.launchpad.net/devel/juju/series'
$ghReleasesFmt = 'https://github.com/juju/juju/releases/tag/v{0}'

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
  $release_url = $ghReleasesFmt -f $($Latest.RemoteVersion)

  $release_page = $null
  try {
    $release_page = Invoke-WebRequest -Uri $release_url -UseBasicParsing
  }
  catch {
    Write-Warning "No GitHub release found for $($Latest.RemoteVersion). Leaving the release notes unchanged."
  }

  $release_notes = $release_page.Links | Where-Object href -match "release-notes|roadmap-releases" | Select-Object -First 1 -expand href

  if ($release_page -and -not $release_notes) {
    Write-Warning "Release notes not found within body of the GitHub release. Linking directly to release."
    $release_notes = $release_url
  }

  if ($release_notes) {
    Update-Metadata -key "releaseNotes" -value $release_notes
  }
}

function global:au_GetLatest {
  $series = (Invoke-RestMethod -Uri $seriesUri).entries |
    Where-Object { $_.active -and $_.name -match '^\d+\.\d+$' } |
    Sort-Object { [version] $_.name } -Descending

  $streams = [ordered] @{}

  $series | ForEach-Object {
    $release = (Invoke-RestMethod -Uri $_.releases_collection_link).entries |
      Sort-Object { Get-Version $_.version } -Descending | Select-Object -First 1
    if (!$release) { return }

    $installer = (Invoke-RestMethod -Uri $release.files_collection_link).entries |
      Where-Object { $_.self_link -match '\.exe$' } | Select-Object -First 1
    if (!$installer) { return }

    $version = Get-Version $release.version

    $streams.Add($_.name, @{
      URL32         = ('{0}/+download/{1}' -f $release.web_link, ($installer.self_link -split '/\+file/')[-1])
      Version       = $version.ToString()
      RemoteVersion = $version.ToString()
    })
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
