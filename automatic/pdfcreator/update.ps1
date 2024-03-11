Import-Module Chocolatey-AU

$releases     = 'http://download.pdfforge.org/download/pdfcreator/list'
$softwareName = 'PDFCreator'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameBase $Latest.FileName32
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
      "(?i)^(\s*softwareName\s*=\s*)'.*'"       = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest $releases -UseBasicParsing
    $re = "\.exe$"
    $url = $download_page.Links | Where-Object href -match $re | Select-Object -Expand href -First 1
    $domain  = $releases -split '(?<=//.+)/' | Select-Object -First 1
    $version = $url -split '/' | Select-Object -Last 1 -Skip 1
    @{
        URL32       = "https://download.pdfforge.org/download/pdfcreator/PDFCreator-stable?download"
        Version     = $version
        PackageName = $softwareName
        FileName32  = $url -split 'file=' | Select-Object -Last 1
        FileType    = 'exe'
    }
}

update -ChecksumFor none
