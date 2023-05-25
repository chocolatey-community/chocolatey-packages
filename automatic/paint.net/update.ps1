Import-Module AU

function global:au_SearchReplace {
  @{
      ".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
        "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
      }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix

  Set-Alias 7z $Env:chocolateyInstall\tools\7z.exe
  7z e tools\*.zip -otools *.exe -r -y
  Remove-Item tools\*.zip -ea 0
}

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease paintdotnet release

    @{
        Version = $LatestRelease.tag_name.TrimStart("v")
        Url64   = $LatestRelease.assets | Where-Object {$_.name -match 'paint.net.+.install.x64.zip'} | Select-Object -ExpandProperty browser_download_url
    }
}

update -ChecksumFor none
