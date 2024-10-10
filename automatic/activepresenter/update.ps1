Import-Module Chocolatey-AU

$releases = 'https://atomisystems.com/download/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*fileType\s*=\s*)('.*')"        = "`$1'$($Latest.FileType)'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*packageName\s*=\s*)('.*')"     = "`$1'$($Latest.PackageName)'"
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
      "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 | ForEach-Object { [uri]::new([uri]$releases, $_.href) }
  $version = $url -split '_' | Select-Object -Last 1 -Skip 1
  $version = $version.Replace('v', '')

  @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
