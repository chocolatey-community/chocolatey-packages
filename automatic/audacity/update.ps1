import-module au

$releases = 'https://fossies.org/windows/misc/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x32:).*"     = "`${1} $($Latest.BaseURL)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
    }

  }
}

function global:au_BeforeUpdate {
  $Latest.Options.Headers  = @{
                                'Referer'    = $Latest.URL32 + "/";
                                'User-Agent' = $Latest.Options.Headers.'User-Agent'
                              }
  Get-RemoteFiles -Purge -FileNameBase $Latest.PackageName
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $installer_exe = $download_page.Links | ? href -match 'audacity-win-.*.exe' | select -First 1 -expand href
  if ($installer_exe) {
    $version = $installer_exe -split '-|.exe' | select -Skip 2 -First 1
  }

  if ($version) {
    $url32 = $releases + "audacity-win-" + $version + ".exe"
  }

  $HTTPheaders = @{
    'Referer'    = $releases;
    'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'
  }

  @{
    URL32    = $url32
    BaseUrl  = $releases
    Options  = @{ Headers  = $HTTPheaders }
    Version  = $version
    FileType = 'exe'
  }
}
update -ChecksumFor none
