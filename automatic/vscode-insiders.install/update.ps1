Import-Module Chocolatey-AU
import-module "$PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1"

$releases64 = 'https://update.code.visualstudio.com/api/update/win32-x64/insider/0000000000000000000000000000000000000000'

if ($MyInvocation.InvocationName -ne '.') {
  function global:au_BeforeUpdate {
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64 -Algorithm $Latest.ChecksumType64
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*url64bit\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"        = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')"    = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $json64 = Invoke-WebRequest -UseBasicParsing -Uri $releases64 | ConvertFrom-Json

  # Strip `-insider`
  $version = $($($json64.productVersion).split('-insider')[0])
  # Get date from timestamp
  $date = $(Get-Date -Format "yyyyMMdd" $(Get-Date 01.01.1970).AddMilliseconds($json64.timestamp))

  @{
    Version        = "$version.$date"
    URL64          = $json64.Url
    ChecksumType64 = 'sha512'
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none
}
