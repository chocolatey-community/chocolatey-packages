Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$zipUrl = 'https://download.sysinternals.com/files/RDCMan.zip'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function GetResultInformation([string]$url) {
  $tempPath = '{0}\rdcman.{1}' -f $Env:TEMP, [Guid]::NewGuid().ToString('N')
  Write-Verbose "Creating temporary path: $tempPath"
  New-Item -ItemType Directory -Path $tempPath | Out-Null
  try
  {

    $destZip = "$tempPath\rdcman.zip"
    Get-WebFile $url $destZip | Out-Null
    $checksumType = 'sha256'
    $checksum32 = Get-FileHash -Path $destZip -Algorithm $checksumType | ForEach-Object { $_.Hash.ToLowerInvariant() }
    Write-Verbose "Checksum ($checksumType): $checksum32"

    Write-Verbose "Unzipping $destZip"
    Expand-Archive -Path $destZip -DestinationPath $tempPath
    $destExe = "$tempPath\rdcman.exe"
    $version = Get-Version (Get-Item $destExe | ForEach-Object { $_.VersionInfo.ProductVersion })
    Write-Verbose "Version: $version"
  }
  finally
  {
    Write-Verbose "Removing temporary path: $tempPath"
    Remove-Item -Path $tempPath -Recurse -Force
  }

  return @{
    URL32            = $url
    Version          = if ($version.Version.Revision -eq '0') { $version.ToString(3) } else { $version.ToString() }
    Checksum32       = $checksum32
    ChecksumType32   = $checksumType
  }
}

function global:au_GetLatest {
  Update-OnETagChanged -execUrl $zipUrl `
    -OnEtagChanged { GetResultInformation $zipUrl } `
    -OnUpdated { @{ URL32 = $zipUrl } }
}

update -ChecksumFor none
