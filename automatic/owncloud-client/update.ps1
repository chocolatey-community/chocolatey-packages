[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module Chocolatey-AU

$releases = 'https://owncloud.com/desktop-app/'
$softwareName = 'ownCloud'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"       = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
  $updateEndpoint = 'https://updates.owncloud.com/client/?platform=win32&currentArch=x86_64&msi=true&version=0.0.0'
  $xmlResponse = Invoke-RestMethod -Uri $updateEndpoint -UseBasicParsing

  @{
    Version = $xmlResponse.owncloudclient.version
    URL64   = $xmlResponse.owncloudclient.downloadurl
  }
}

update -ChecksumFor none
