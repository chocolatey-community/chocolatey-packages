import-module au
import-module "$PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1"

$releases32 = 'https://update.code.visualstudio.com/api/update/win32/insider/VERSION'
$releases64 = 'https://update.code.visualstudio.com/api/update/win32-x64/insider/VERSION'

if ($MyInvocation.InvocationName -ne '.') {
  function global:au_BeforeUpdate {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $json32 = Invoke-WebRequest -UseBasicParsing -Uri $releases32 | ConvertFrom-Json
  $json64 = Invoke-WebRequest -UseBasicParsing -Uri $releases64 | ConvertFrom-Json

  if ($json32.productVersion -ne $json64.productVersion) {
    throw "Different versions for 32-Bit and 64-Bit detected."
  }

  # Strip `-insider`
  $version = $($($json32.productVersion).split('-insider')[0])
  # Get date from timestamp
  $date = $(Get-Date -Format "yyyyMMdd" $(Get-Date 01.01.1970).AddMilliseconds($json32.timestamp))

  @{
    Version = "$version.$date"
    URL32   = $json32.Url
    URL64   = $json64.Url
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none
}
