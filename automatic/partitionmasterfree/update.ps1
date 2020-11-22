import-module au
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$exec = "https://down.easeus.com/product/epm_free"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      '(?i)(^\s*file\s*=\s*)(".*")'   = "`$1`"`$toolsPath\$($Latest.FileName32)`""
    }
  }
}

function GetResultInformation([string]$url32) {
    Remove-Item $PSScriptRoot\tools\*.exe

    $url32 = Get-RedirectedUrl $url32
    $name = $url32 -split '/' | Select -Last 1
    $dest = Join-Path "$PSScriptRoot\tools" $name

    Get-WebFile $url32 $dest
    & $PSScriptRoot\installer_download.ahk $dest
    for ($i=0; $i -lt 60; $i++) {
      Sleep 1
      $installer = ls -Exclude $name tools\*.exe | select -First 1
      if ($installer) { Get-Process EDownloader -ea 0 | kill; break }
    }
    if (!$installer) { throw "Can't download installer via AHK"}
    Remove-Item $PSScriptRoot\tools\$name

    $version = Get-Item $installer | % { $_.VersionInfo.ProductVersion }

    $checksumType = 'sha256'
    @{
        URL32          = $url32
        Version        = Get-Version $version
        Checksum32     = Get-FileHash $installer -Algorithm $checksumType | % { $_.Hash.ToLowerInvariant() }
        ChecksumType32 = $checksumType
        PackageName    = 'PartitionMasterFree'
        FileName32     = $installer.Name
    }
}

function global:au_GetLatest {
    Update-OnETagChanged -execUrl $exec -OnEtagChanged {
        GetResultInformation $exec
    } -OnUpdated { @{ URL32 = $exec } }
}

update -ChecksumFor none
