Import-Module Chocolatey-AU

$softwareName = 'djv-*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..*)\<.*\>"              = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(`"[$]toolsPath\\)[^`"]*`""    = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^\s*SoftwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease darbyjohnston DJV

  @{
    URL64    = $LatestRelease.assets.Where{$_.name.EndsWith('.exe')}.browser_download_url
    Version  = Get-Version $LatestRelease.tag_name
    FileType = 'exe'
  }
}

update -ChecksumFor none
