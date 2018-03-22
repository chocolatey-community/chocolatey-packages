Import-Module AU

$versions     = 'https://patchmypc.net/release-notes'

function global:au_AfterUpdate {
  Remove-Item -Force "$PSScriptRoot\tools\*.exe"
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}
function global:au_GetLatest {
  $url32 = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'

  $version_page = Invoke-WebRequest -Uri $versions -UseBasicParsing
  $re = New-Object regex("\>What(?:'|&#039;)s new in ([\d\.]+)")
  $version32 = $re.Match($version_page.Content).Groups[1]

  @{
    URL32 = $url32
    Version = $version32
  }
}

update -ChecksumFor 32
