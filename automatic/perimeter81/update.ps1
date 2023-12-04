import-module au

$releases = "https://support.perimeter81.com/docs/windows-agent-release-notes"
$downloadBase = "https://static.perimeter81.com/agents/windows"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*fileType\s*=\s*)('.*')"       = "`$1'$($Latest.FileType)'"
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL32
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest $releases

  $latest = $download_page.AllElements | Where-Object innerText -match "^Windows agent (\d+\.\d+\.\d+\.\d+).*$" | Select-Object -First 1
  $version = Get-Version $Matches[1]
  $downloadUrl = "$($downloadBase)/Perimeter81_$($version).msi"

  return @{
    URL32 = $downloadUrl
    Version = $version
    FileType = "msi"
  }
}

update -ChecksumFor none
