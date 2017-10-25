import-module au

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
  }
}


function global:au_BeforeUpdate() {
  #Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
  Get-RemoteFiles -Purge
}


function global:au_GetLatest {
  $allVersions = Invoke-WebRequest -Uri https://api.github.com/repos/henrypp/chromium/releases -UseBasicParsing | ConvertFrom-Json
  $allStableVersions = $allVersions | Where-Object {$_.body -match "stable"}
  $latestStableVersionNumber = ($allStableVersions[0].tag_name.split('-') | Select-Object -First 1) -replace 'v', ''
  $anyArchLatestStablesVersions = $allVersions  | Where-Object {$_.tag_name -match $latestStableVersionNumber}

  $32LatestVersion = $anyArchLatestStablesVersions | Where-Object {$_.tag_name -match $latestStableVersionNumber -and $_.tag_name -match "win32"}
  $32LatestSyncInstallUrl = ($32LatestVersion.assets | Where-Object name -match "-sync.exe").browser_download_url

  $64LatestVersion = $anyArchLatestStablesVersions | Where-Object {$_.tag_name -match $latestStableVersionNumber -and $_.tag_name -match "win64"}
  $64LatestSyncInstallUrl = ($64LatestVersion.assets | Where-Object name -match "-sync.exe").browser_download_url

  $ChecksumType = 'sha256'

  $Latest = @{
    Version        = $latestStableVersionNumber
    URL32          = $32LatestSyncInstallUrl
    ChecksumType32 = $ChecksumType
    URL64          = $64LatestSyncInstallUrl
    ChecksumType64 = $ChecksumType
  };

  return $Latest
}

Update-Package -ChecksumFor none
