. "$PSScriptRoot\..\7zip\update.ps1"

$softwareNamePrefix = '7-zip'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -FileNameBase '7zip'
  $Latest.ChecksumType = 'sha256'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*softwareName\s*=\s*)'.*'" = "`$1'$softwareNamePrefix $($Latest.RemoteVersion)*'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(\s*\-SoftwareName\s+)'.*'" = "`$1'$softwareNamePrefix $($Latest.RemoteVersion)*'"
    }
  }
}

update -ChecksumFor none
