Import-Module Chocolatey-AU

$latestRelease = 'https://api.github.com/repos/cyd01/KiTTY/releases/latest'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s*zip file\:).*"           = "`${1} $($Latest.URL32)"
      "(?i)(^\s*SHA256\:).*"            = "`${1} $($Latest.Hash)"
      "(?i)(^\s*Get-RemoteChecksum ).*" = "`${1} $($Latest.URL32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*FileFullPath\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $assets = (Invoke-RestMethod $latestRelease).assets
  $fileName = $assets[0].name
  $version = $fileName.Replace("kitty-bin-", "").Replace(".zip", "")
  $Hash = Get-RemoteChecksum $assets[0].browser_download_url

  @{
    URL32      = $assets[0].browser_download_url
    Version    = $version
    Hash       = $Hash
    ZipFile    = $fileName
  }
}

update -ChecksumFor none
