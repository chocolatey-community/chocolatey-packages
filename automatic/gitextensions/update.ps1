Import-Module Chocolatey-AU

$softwareName = 'Git Extensions*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    'legal\VERIFICATION.txt'        = @{
      "(?i)(url:.+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum:\s+).*"      = "`${1}$($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"      = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease -Owner "gitextensions" -Name "gitextensions"

  $re = 'GitExtensions-(.+)\.msi$'
  $downloadUrl = $LatestRelease.assets.browser_download_url | Where-Object { $_ -match $re } | Select-Object -First 1
  $releaseUrl = $LatestRelease.html_url
  
  $version = ($downloadUrl -split '\/' | Select-Object -last 1 -skip 1).Substring(1)

  $version = $version -replace ".RC", "-RC"

  if(($version.ToCharArray() | Where-Object {$_ -eq '.'} | Measure-Object).Count -eq 0) {
    $version = $version + ".0.0"
  } elseif(($version.ToCharArray() | Where-Object {$_ -eq '.'} | Measure-Object).Count -eq 1) {
    $version = $version + ".0"
  }

  $pre = ""
  if ($version -match '^.*(-.*?)\..*$') {
    $pre = $version -replace '^.*(-.*?)\..*$', "`$1"
    $version = $version -replace $pre, ""
  }

  $version = $version + $pre
  
  $version = Get-Version $version

  return @{
    Version        = $version
    URL32          = $downloadUrl 
    ReleaseURL     = $releaseUrl
  }
}

update -ChecksumFor none
