import-module au

$releases = 'https://filehippo.com/download_audacity/post_download/'

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

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase $Latest.PackageName }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  if ($download_page.Content -match '"softwareVersion"\s*:\s*"Audacity ([\d\.]+)"') {
    $version = $Matches[1]
  }

  if ($download_page -match "downloadIframe.src\s*=\s*['`"](https[^'`"]+)['`"]") {
    $url32 = $Matches[1]
  }

  @{
    URL32    = $url32
    BaseUrl  = $releases
    Version  = $version -split ' ' | ? { ($_ -as [version] -is [version]) } | select -First 1
    FileType = 'exe'
  }
}
update -ChecksumFor none
