Import-Module AU

$softwareName = 'Git Extensions*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    'legal\VERIFICATION.txt'        = @{
      "(?i)(url:.+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum:\s+).*"      = "`${1}$($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"      = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri 'https://github.com/gitextensions/gitextensions/releases' -UseBasicParsing

  $urls = $download_page.Links | ? href -match 'GitExtensions-(.+)\.msi$' | select -expand href | % { 'https://github.com' + $_ }

  $streams = @{}
  $urls | % {
    $version = $_ -split '\/' | select -last 1 -skip 1
    if ($version -match '\.[a-z][a-z\d]*$') {
      $version = $version -replace '\.([a-z][a-z\d]*)$', "-`$1"
    }
    $version = Get-Version $version

    if (!($streams.ContainsKey($version.ToString(2)))) {
      $streams.Add($version.ToString(2), @{
          Version = $version.ToString()
          URL32   = $_
        })
    }
  }

  return @{ Streams = $streams }
}

Update-Package -ChecksumFor none
