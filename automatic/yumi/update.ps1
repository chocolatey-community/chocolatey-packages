Import-Module AU

$domain   = 'http://www.pendrivelinux.com'
$releases = "$domain/yumi-multiboot-usb-creator/"

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"

  $filePath = "$PSScriptRoot\tools\yumi.exe"
  Invoke-WebRequest -Uri $Latest.URL32 -UseBasicParsing -OutFile $filePath
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32     = Get-FileHash -Path $filePath -Algorithm $Latest.ChecksumType32 | % Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>"  = "`${1}<$releases>"
      "(?i)(^1\..*)\<.*\>"            = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"   = "`${1} $($Latest.Checksum32)"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'YUMI\-[\d\.]+\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $version32 = $url32 -split '[-]|\.exe' | select -last 1 -skip 1
  @{
    URL32   = $domain + $url32
    Version = $version32
  }
}

update -ChecksumFor none

