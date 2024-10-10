Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
      ".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
        "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
      }
      ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileNameMsi64)`""
      }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix

  Set-Alias -Name 7z -Value $Env:chocolateyInstall\tools\7z.exe
  7z e tools\*.zip -otools *.msi -r -y
  Remove-Item tools\*.zip -ea 0
}

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease paintdotnet release

    @{
        Version = $LatestRelease.tag_name.TrimStart("v")
        Url64   = $LatestRelease.assets | Where-Object {$_.name -match 'paint.net.+.winmsi.x64.zip'} | Select-Object -ExpandProperty browser_download_url
        FileNameMsi64  = $LatestRelease.assets | Where-Object {$_.name -match 'paint.net.+.winmsi.x64.zip'} | Select-Object -ExpandProperty Name | ForEach-Object {$_ -replace "zip","msi"}
      }
}

update -ChecksumFor none
