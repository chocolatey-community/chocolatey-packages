Import-Module AU

$global:getBetaVersion

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
    $downloadEndPointUrl = 'https://www.binaryfortress.com/Data/Download/?package=logfusion&log=117'
    $versionRegEx = '.*LogFusionSetup-([0-9\.\-]+)\.exe$'

    $downloadUrl = ((Get-WebURL -Url $downloadEndPointUrl).ResponseUri).AbsoluteUri
    $version = $($downloadUrl -replace $versionRegEx, '$1')

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update -ChecksumFor None
