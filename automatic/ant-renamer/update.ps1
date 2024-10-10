Import-Module Chocolatey-AU

$releases = 'http://www.antp.be/software/renamer/download'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $re    = 'install\.exe'
    $url   = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -ExpandProperty href
    if (-not ([uri]$url).Scheme) {
      $url = "$(([uri]$releases).Scheme)://$($url.TrimStart('https://'))"
    }

    $version  = [regex]::Match($download_page.Content, "Version\s+([0-9\.]+)").Groups[1].Value;

    return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
