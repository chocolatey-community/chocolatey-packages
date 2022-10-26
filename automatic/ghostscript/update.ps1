Import-Module AU

function global:au_SearchReplace {
  [version]$version = $Latest.RemoteVersion
  $docsUrl = "http://www.ghostscript.com/doc/$($version)/Readme.htm"
  $releaseNotesUrl = "https://ghostscript.com/doc/$($version)/History$($version.Major).htm"
  @{
    ".\Ghostscript.nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).app`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
      "(?i)(^\s*\<docsUrl\>).*(\<\/docsUrl\>)" = "`${1}$docsUrl`${2}"
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" ` = "`${1}$releaseNotesUrl`${2}"
    }
  }
}
function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease ArtifexSoftware ghostpdl-downloads

  $Url32 = $LatestRelease.assets | Where-Object {$_.name -eq "$($LatestRelease.tag_name)w32.exe"} | Select-Object -ExpandProperty browser_download_url
  $Url64 = $LatestRelease.assets | Where-Object {$_.name -eq "$($LatestRelease.tag_name)w64.exe"} | Select-Object -ExpandProperty browser_download_url

  # Linux version easily exposes the correct version as we expect so we use
  # that version as the base. Could use release name, but doesn't match pre-release.
  $LinuxRelease = $LatestRelease.assets | Where-Object {$_.name -match "ghostscript-.+\.tar\.gz"} | Select-Object -ExpandProperty name
  $Version = $LinuxRelease -replace "^ghostscript-(?<Version>.+)\.tar\.gz$", '${Version}'

  if (!$Url32 -or !$Url64) {
    throw "Either 32bit or 64bit URL is missing, please verify this is correct!"
  }

  @{
    URL32 = $Url32
    URL64 = $Url64
    Version = $Version
    RemoteVersion = $Version
    PackageName = 'Ghostscript'
  }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
