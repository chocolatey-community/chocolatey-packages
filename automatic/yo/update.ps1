Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    'tools\ChocolateyInstall.ps1' = @{
      "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.RemoteVersion)'"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease yeoman yo
  $Version = $LatestRelease.tag_name.TrimStart("v")

  @{
    Version       = Get-Version $Version
    RemoteVersion = $Version
  }
}

update -ChecksumFor none
