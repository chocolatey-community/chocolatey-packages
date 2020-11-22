import-module au
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$exec = "https://down.easeus.com/product/epm_free"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function GetResultInformation([string]$url32) {
    $url32 = Get-RedirectedUrl $url32
    $dest = Join-Path $env:TEMP ($exec -split '/' | select -Last 1)
    $checksumType = 'sha256'
    Get-WebFile $url32 $dest
    $version = Get-Item $dest | % { $_.VersionInfo.ProductVersion }
    $version = if ($version) { Get-Version $version } else {
      $re = "What's new in version (.+?)</p>"
      $version = Invoke-WebRequest https://www.easeus.com/partition-manager/epm-free.html
      if ($version -match $re) { $Matches[1].Trim() } else { throw "Can't find version" }
    }
    $checksum32 = Get-FileHash $dest -Algorithm $checksumType | % { $_.Hash.ToLowerInvariant() }

    return @{
        URL32          = $url32
        Version        = $version
        Checksum32     = $checksum32
        ChecksumType32 = 'sha256'
        PackageName    = 'PartitionMasterFree'
    }
}

function global:au_GetLatest {
    Update-OnETagChanged -execUrl $exec -OnEtagChanged {
        GetResultInformation $exec
    } -OnUpdated { @{ URL32 = $exec } }
}

update -ChecksumFor none
