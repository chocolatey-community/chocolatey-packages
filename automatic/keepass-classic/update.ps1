Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$releases           = 'http://keepass.info/download.html'
$changelog_domain   = 'http://keepass.info/news'
$changelogs         = "$changelog_domain/news_all.html"
$softwareNamePrefix = 'KeePass Password Safe'

function global:au_BeforeUpdate {
  Remove-Item -Force "$PSScriptRoot\tools\*.exe"
  $Latest.FileName32 = Get-WebFileName $Latest.URL32 "keepass-classic.exe"
  $Latest.ChecksumType32 = 'sha256'
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName32)"
  Get-WebFile -Url $Latest.URL32 -FileName $filePath
  $Latest.Checksum32 = Get-FileHash $filePath -Algorithm $Latest.ChecksumType32 | % Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$($Latest.SoftwareName)'"
      "(?i)(^[$]filePath\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName32)`""
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(?i)(^\s*\<projectSourceUrl\>).*(\<\/projectSourceUrl\>)" = "`${1}$($Latest.ProjectSourceUrl)`${2}"
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)"         = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'KeePass.*1\.x\/.*\.exe\/download$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href
  $fileName = $url32 -split '/' | select -last 1 -skip 1
  $index = $url32.IndexOf($fileName)
  $sourceUrl = $url32.Substring(0, $index)

  $verRe = '[-]'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1

  $changelog_page = Invoke-WebRequest -uri $changelogs -UseBasicParsing

  $re = "KeePass ${version32} released"
  $URLChangelog = $changelog_page.Links | ? outerHtml -match $re | select -first 1 -expand href
  if ($URLChangelog) { $URLChangelog = "$changelog_domain/$URLChangelog" }

  $majorVersion = $version32 -split '\.' | select -first 1

  @{
    URL32 = $url32
    Version = $version32
    ReleaseNotes = $URLChangelog
    ProjectSourceUrl = $sourceUrl
    SoftwareName     = '{0} {1}*' -f $softwareNamePrefix,$majorVersion
  }
}

update -ChecksumFor none
