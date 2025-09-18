Import-Module Chocolatey-AU

$releases = 'https://www.ccleaner.com/speccy/version-history'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $downloadPage = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $downloadPage.Content -match "v((?:[\d]\.)[\d\.]+)\</span\>"
  $version = $Matches[1]
  $versionParts = $version.Split(".")

  $url = "https://download.ccleaner.com/spsetup$($versionParts[0])$($versionParts[1]).exe"

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
