Import-Module Chocolatey-AU

$downloadUrl = "https://down.easeus.com/product/epm_free"

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

function global:au_GetLatest {
    Remove-Item $PSScriptRoot\tools\*.exe

    $downloaderPath = "$PSScriptRoot\tools\downloader.exe"
    Invoke-WebRequest $downloadUrl -OutFile $downloaderPath

    & $PSScriptRoot\installer_download.ahk $downloaderPath
    for ($i=0; $i -lt 60; $i++) {
      Start-Sleep 1
      $installer = Get-ChildItem -Exclude downloader.exe tools\*.exe | Select-Object -First 1
      if ($installer) { Get-Process EDownloader -ea 0 | Stop-Process; break }
    }
    if (!$installer) { throw "Can't download installer via AHK"}
    Remove-Item $downloaderPath

    $version = (Get-Item $installer).VersionInfo.ProductVersion

    $checksumType = 'sha256'
    @{
        URL32          = $downloadUrl
        Version        = Get-Version $version
        Checksum32     = Get-FileHash $installer -Algorithm $checksumType | ForEach-Object { $_.Hash.ToLowerInvariant() }
        ChecksumType32 = $checksumType
        PackageName    = 'PartitionMasterFree'
        FileName32     = $installer.Name
    }
}

update -ChecksumFor none
