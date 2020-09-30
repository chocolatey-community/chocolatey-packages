Import-Module AU

$softwareName = 'PDFCreator'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"       = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri "https://download.pdfforge.org/download/pdfcreator/" -UseBasicParsing
  $stableReleaseLink = $download_page.Links | ? href -match "/download/pdfcreator/PDFCreator-stable" | % outerHTML
  $stableReleaseLink = $stableReleaseLink.Substring(60).Replace("-Setup.exe</a>","")
  $version32 = $stableReleaseLink.Replace("_",".")
  $url32 = "https://download.pdfforge.org/download/pdfcreator/$version32/PDFCreator-$stableReleaseLink-Setup.exe"

  return @{
    URL32       = $url32
    Version     = $version32
    PackageName = 'PDFCreator'
  }
}

update -ChecksumFor none
