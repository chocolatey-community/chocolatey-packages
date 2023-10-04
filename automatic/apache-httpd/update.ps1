Import-Module au

$releases = 'https://www.apachelounge.com/download/'

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix }

function global:au_GetLatest {
  return @{
    Url32   = "https://www.apachelounge.com/download/VS17/binaries/httpd-2.4.57-win32-VS17.rar"
    Url64   = "https://www.apachelounge.com/download/VS17/binaries/httpd-2.4.57-win64-VS17.zip"
    Version = "2.4.57"
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
