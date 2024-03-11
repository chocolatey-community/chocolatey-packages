Import-Module Chocolatey-AU

$releases = 'https://www.mixxx.org/download'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    '.\legal\VERIFICATION.txt'    = @{
      '(?i)(Go to)\s*<.*>'  = "`${1} <$releases>"
      '(?i)(\s+x64:).*'     = "`${1} $($Latest.URL64)"
      '(?i)(checksum64:).*' = "`${1} $($Latest.Checksum64)"
    }
    'tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re = 'win..\.msi$'
  $urls = $download_page.links | Where-Object href -Match $re | Select-Object -ExpandProperty href

  $streams = @{}

  $urls | ForEach-Object {
    if ($_ -match 'snapshots') {
      $splits = $_ -split '-' | Select-Object -Skip 1
      $version = ($splits | Select-Object -First 3) -join '-'
      $key = $splits | Select-Object -Skip 1 -First 1
    }
    else {
      $version = $_ -split '/' | Select-Object -Last 1 -Skip 1
      $key = 'stable'
    }

    if (!$streams.ContainsKey($key)) {
      $streams.Add($key, @{
          Version        = $version.Replace('mixxx-', '')
          URL64          = $_
          ChecksumType64 = 'sha512'
        })
    }
  }

  return @{Streams = $streams }
}

update -ChecksumFor none
