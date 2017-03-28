Import-Module AU

$releases     = 'https://ghostscript.com/download/gsdnld.html'
$softwareName = 'GPL Ghostscript'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  [version]$version = $Latest.RemoteVersion
  $docsUrl = "http://www.ghostscript.com/doc/$($version)/Readme.htm"
  $releaseNotesUrl = "https://ghostscript.com/doc/$($version)/History$($version.Major).htm"
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^[$]filePath32\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName32)`""
      "(?i)(^[$]filePath64\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
    ".\Ghostscript.app.nuspec" = @{
      "(?i)(^\s*\<docsUrl\>).*(\<\/docsUrl\>)" = "`${1}$docsUrl`${2}"
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" ` = "`${1}$releaseNotesUrl`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'w32\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $re = 'w64\.exe$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href

  $verRe = 'Ghostscript\s*([\d]+\.[\d\.]+) for Windows'
  $Matches = $null
  $download_page.Content -match $verRe | Out-Null
  if ($Matches) {
    $version = $Matches[1]
  }

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version
    RemoteVersion = $version
  }
}

update -ChecksumFor none
