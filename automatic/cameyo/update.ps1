Import-Module AU

$releases     = 'http://www.cameyo.com/download'
$versions     = 'http://www.cameyo.com/products'

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 -Algorithm $Latest.ChecksumType32
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
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'Retrieve&(amp;)pkgId=1$'
  $url32 = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href
  $url32 = $url32 -replace '&amp;','&'

  $version_page = Invoke-WebRequest -uri $versions
  $version = $version_page.AllElements | ? innerText -match '^\s*([\d]+\.){1,3}[\d]+\s*$' | select -first 1 -expand innerText
  $version = $version.Trim()
  @{
    URL32 = $url32
    Version = $version
  }
}

#  Update-Package -ChecksumFor none
 
 Write-Host "Cameyo update disabled due to site change (See #848: https://goo.gl/DD92Bf)"
 return "ignore"
