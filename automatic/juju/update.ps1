import-module au
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"

$releases = 'https://launchpad.net/juju/+download'

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"

  $Latest.FileName = Get-WebFileName $Latest.URL32 'juju.exe'
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"

  Get-WebFile $Latest.URL32 $filePath

  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-FileHash -Algorithm $Latest.ChecksumType32 -Path $filePath | % Hash
}

function global:au_AfterUpdate { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName)`""
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
