Import-Module AU

$domain       = 'https://www.noip.com'
$releases     = "$domain/download?page=win"
$softwareName = 'No-IP DUC'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
    ".\no-ip-duc.nuspec" = @{
      "(?i)(\s*\<docsUrl\>).*(\<\/docsUrl\>)" = "`${1}$($Latest.DocumentationURL)`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href
  if ($url32) { $url32 = $domain + $url32 }

  $verRe = '_v|\.exe'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  $version32 = $version32 -replace '_','.'

  $docsUrl = $download_page.Links | ? href -match "knowledgebase\/installing" | select -first 1 -expand href
  if ($docsUrl) { $docsUrl = $domain + $docsUrl }

  @{
    URL32 = $url32
    Version = $version32
    DocumentationURL = $docsUrl
  }
}

update -ChecksumFor 32
