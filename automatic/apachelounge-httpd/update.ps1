Import-Module Chocolatey-AU

$releases = 'https://www.apachelounge.com/download/'

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix }

function global:au_GetLatest {
  $versionRegEx = 'httpd\-([\d\.]+).*?\-win32\-([vV][sS]17).*?\.zip'

  $checksumType = 'sha256' # 64-characters long
  $checksumRegEx = "^$($checksumType)\-Checksum for: $($versionRegEx):\W+(?<hash>[0-9A-F]{64})\W?$"
  $checksumRegExOptions = [Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [Text.RegularExpressions.RegexOptions]::Multiline

  $downloadPage = Invoke-WebRequest $releases -UseBasicParsing  -UserAgent Chocolatey
  $reMatches = [regex]::match($downloadPage.Content, $versionRegEx)
  $version32 = $reMatches.Groups[1].Value
  $url32 = "https://www.apachelounge.com/download/VS17/binaries/$($reMatches.Groups[0].Value)"
  $urlChecksum32 = "https://www.apachelounge.com/download/VS17/binaries/$($reMatches.Groups[0].Value).txt"

  $versionRegEx = $versionRegEx -replace 'win32', 'win64'
  $reMatches = [regex]::match($downloadPage.Content, $versionRegEx)
  $version64 = [version]$reMatches.Groups[1].Value
  $url64 = "https://www.apachelounge.com/download/VS17/binaries/$($reMatches.Groups[0].Value)"
  $urlChecksum64 = "https://www.apachelounge.com/download/VS17/binaries/$($reMatches.Groups[0].Value).txt"

  if ($version32 -ne $version64) {
    throw "32bit and 64bit version do not match. Please check the update script."
  }

  # Get expected checksums from Apache Lounge
  $downloadPage = Invoke-WebRequest $urlChecksum32 -UseBasicParsing  -UserAgent Chocolatey
  $reMatches = [regex]::match($downloadPage.Content, $checksumRegEx, $checksumRegExOptions)
  $checksum32 = [string]$reMatches.Groups['hash'].value

  $checksumRegEx = $checksumRegEx -replace 'win32', 'win64'
  $downloadPage = Invoke-WebRequest $urlChecksum64 -UseBasicParsing  -UserAgent Chocolatey
  $reMatches = [regex]::match($downloadPage.Content, $checksumRegEx, $checksumRegExOptions)
  $checksum64 = [string]$reMatches.Groups['hash'].value

    return @{
    Url32   = $url32
    Url64   = $url64
    Version = $version32
    ChecksumType32 = $checksumType
    Checksum32 = $checksum32
    Checksum64 = $checksum64
  }
}

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(32-Bit.+)\<.*\>"     = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>"     = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum32:).*"      = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*"      = "`${1} $($Latest.Checksum64)"
    }
  }
}

update -ChecksumFor None
