Import-Module au

$releases = 'https://www.apachelounge.com/download/'

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix }

function global:au_GetLatest {
  $versionRegEx = 'httpd\-([\d\.]+).*?\-win32\-([vV][sS]17).*?\.zip'

  $downloadPage = Invoke-WebRequest $releases -UseBasicParsing -UserAgent Chocolatey
  $matches = [regex]::match($downloadPage.Content, $versionRegEx)
  $version32 = $matches.Groups[1].Value
  $url32 = "https://www.apachelounge.com/download/VS17/binaries/$($matches.Groups[0].Value)"

  $versionRegEx = $versionRegEx -replace 'win32', 'win64'
  $matches = [regex]::match($downloadPage.Content, $versionRegEx)
  $version64 = [version]$matches.Groups[1].Value
  $url64 = "https://www.apachelounge.com/download/VS17/binaries/$($matches.Groups[0].Value)"

  if ($version32 -ne $version64) {
    throw "32bit and 64bit version do not match. Please check the update script."
  }

  return @{
    Url32   = $url32
    Url64   = $url64
    Version = $version32
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
