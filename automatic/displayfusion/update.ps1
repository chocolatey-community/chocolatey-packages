[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module Chocolatey-AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s*1\..+)\<.*\>"          = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"   = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $urls = @(
    "https://www.binaryfortress.com/Data/Download/?package=displayfusion&log=101&beta=0" # This URL redirects to the stable version
    "https://www.binaryfortress.com/Data/Download/?package=displayfusion&log=101&beta=1" # This URL returns a 404 when the beta is removed
  )

  $streams = @{}
  $urls | ForEach-Object {
    $releaseUrl = $_
    try {
      $url = Get-RedirectedUrl $releaseUrl 3>$null
      $verRe = 'Setup-|\.exe$'
      $version = $url -split "$verRe" | Select-Object -last 1 -skip 1
      if (!$version) { return }
      $version = Get-Version $version

      if (($releaseUrl -match 'beta=1') -and !$version.PreRelease) {
        $version += "-beta"
        $version.PreRelease = "beta"
      }

      if ($version.PreRelease) {
        $key = "unstable"
      }
      else {
        $key = "stable"
      }

      if (!($streams.ContainsKey($key))) {
        $streams.Add($key, @{
            Version = $version.ToString()
            URL32   = $url
          })
      }
    }
    catch {
      if (($releaseUrl -match 'beta=1')) {
        $streams.Add("unstable", "ignore")
      }
      else {
        throw
      }
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
