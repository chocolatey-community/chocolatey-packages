Import-Module au

$global:getBetaVersion = $false
$global:stableVersionDownloadUri = 'https://www.dropbox.com/download?full=1&plat=win'
$global:stableVersionRegEx = '.*Dropbox%20([0-9\.]+).*'
$global:betaVersionReleasePageUri = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
$global:betaVersionDownloadUri = 'https://clientupdates.dropboxstatic.com/client/Dropbox%20$($betaVersion)%20Offline%20Installer.exe'
$global:betaVersionRegEx = '.*Beta-Build-([0-9\.\-]+).*'

function global:Get-FirstBetaLink([string] $uri, [string] $regEx) {
  $progressPreference = 'silentlyContinue'
  $html = Invoke-WebRequest -UseBasicParsing -Uri $uri
  $progressPreference = 'Continue'

  return $html.links | Where-Object { $_.href -match $regEx } | Select-Object -First 1
}

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  if ($global:getBetaVersion) {
    $betaVersion = ((Get-FirstBetaLink $global:betaVersionReleasePageUri $global:betaVersionRegEx) -replace $global:betaVersionRegEx, '$1') -replace '-', '.'
    $betaVersionDownloadUri = $ExecutionContext.InvokeCommand.ExpandString($global:betaVersionDownloadUri)

    return @{ URL32 = $betaVersionDownloadUri; Version = $betaVersion }
  }

  $stableVersionDownloadUri = Get-RedirectedUrl $global:stableVersionDownloadUri
  $stableVersion = $($stableVersionDownloadUri -replace $global:stableVersionRegEx, '$1')

  return @{ URL32 = $stableVersionDownloadUri; Version = $stableVersion }
}

Function Get-RedirectedUrl {
    Param (
        [Parameter(Mandatory=$true)][String]$url
    )

    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect = $false
    $response = $request.GetResponse()

    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}

update -ChecksumFor 32
