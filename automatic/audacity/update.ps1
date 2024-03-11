Import-Module Chocolatey-AU

$releases = 'https://www.audacityteam.org/download/windows/'

function global:au_SearchReplace {
  @{
    '.\tools\chocolateyInstall.ps1' = @{
      "(^\s*packageName\s*=\s*)('.*')"           = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }

    '.\legal\VERIFICATION.txt'      = @{
      '(?i)(Go to).*<.*>'   = "`${1} <$($releases)>"
      '(?i)(\s+x32:).*'     = "`${1} $($Latest.URL32)"
      '(?i)(\s+x64:).*'     = "`${1} $($Latest.URL64)"
      '(?i)(checksum32:).*' = "`${1} $($Latest.Checksum32)"
      '(?i)(checksum64:).*' = "`${1} $($Latest.Checksum64)"
    }

  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $installers = $download_page.Links | Where-Object href -Match 'github.*\.exe$' | Select-Object -ExpandProperty href

  $url64 = $installers | Where-Object { $_ -match '-64bit|-x64' } | Select-Object -First 1
  $version = $url64 -split '/' | Select-Object -Last 1 -Skip 1
  $version = $version.Replace('Audacity-', '')
  $url32 = $installers | Where-Object { $_ -match "-32bit|-x32" } | Select-Object -First 1

  @{
    URL32   = $url32
    URL64   = $url64
    Version = $version
  }
}

update -ChecksumFor none
