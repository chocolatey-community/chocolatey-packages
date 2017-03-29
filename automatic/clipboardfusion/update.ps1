Import-Module AU

$global:getBetaVersion = $false

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'

  Get-RemoteFiles -Purge

  $file = Get-ChildItem $PSScriptRoot\tools -Filter "*.exe" | select -First 1 | % { Get-Item $_.FullName }
  Remove-Item $file -Force
}

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]installer\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileName($Latest.Url32))'"
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $stableVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104'
  $stableVersionRegEx = 'ClipboardFusionSetup-([0-9\.\-]+)\.exe'

  if ($global:getBetaVersion) {
    $betaVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&beta=1&log=104'
    $betaVersionRegEx = 'ClipboardFusionSetup-([0-9\.\-]+)-Beta([0-9]+)'

    $betaVersionDownloadUrl = ((Get-WebURL -Url $betaVersionDownloadUrl).ResponseUri).AbsoluteUri
    $versionInfo = $betaVersionDownloadUrl -match $betaVersionRegEx

    if ($matches) {
      $betaVersion = "$($matches[1]).$($matches[2])"
    }
    
    return @{ Url32 = $betaVersionDownloadUrl; Version = $betaVersion }
  }

  $stableVersionDownloadUrl = ((Get-WebURL -Url $stableVersionDownloadUrl).ResponseUri).AbsoluteUri
  $versionInfo = $stableVersionDownloadUrl -match $stableVersionRegEx

  if ($matches) {
    $stableVersion = $matches[1]
  }

  return @{ Url32 = $stableVersionDownloadUrl; Version = $stableVersion }
}

Update -ChecksumFor None
