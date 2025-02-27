Import-Module Chocolatey-AU

$releases = 'https://api.github.com/repos/adobe/brackets/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-RestMethod -Uri $releases
  $urls = @()
  $download_page | ForEach-Object {
    $_.assets | ForEach-Object {
      if ($_.browser_download_url -match '[\d\.]+\.msi$' -and $_.browser_download_url -notmatch 'prerelease' -and $_.prerelease -ne $True) {
        $urls += $_.browser_download_url
      }
    }
  }
  $url32 = $urls[0]
  if (!$url32) { Write-Host 'No Windows release is avaialble'; return 'ignore' }
  $version32 = ($url32 -split '/' | select -last 1) -replace '\.msi$' -replace '^Brackets.Release.'
  @{
    URL32 = $url32
    Version = $version32
    PackageName = 'Brackets'
  }
}

update -ChecksumFor none
