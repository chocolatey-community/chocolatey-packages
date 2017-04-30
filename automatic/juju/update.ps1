import-module au
. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"

$releases = 'https://launchpad.net/juju/+download'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName32)`""
    }
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(1\..+)\<.*\>"      = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum:).*"      = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = '\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href


  # special case, sometimes uses -signed other times it's a pre-release
  $versionArr  = $url -split 'setup[-]|[-]signed|.exe' | select -Last 2 -Skip 1

  if ($versionArr[1]) {
    $version = $versionArr[1];
  } else {
    $version = $versionArr[0];
  }

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor none
