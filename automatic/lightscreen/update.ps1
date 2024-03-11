Import-Module Chocolatey-AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(type:).*"       = "`${1} $($Latest.ChecksumType32)"
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key 'releaseNotes' -value $Latest.ReleaseNotes
}

function global:au_GetLatest {
  $release = Get-GitHubRelease 'ckaiser' 'Lightscreen'
  $version = $release.tag_name.TrimStart('v')
  $url32 = $release.assets | Where-Object name -match '\.exe$' | Select-Object -ExpandProperty browser_download_url

  return @{
    URL32        = $url32
    Version      = Get-Version $version
    ReleaseNotes = $release.body
  }
}

Update-Package -ChecksumFor none
