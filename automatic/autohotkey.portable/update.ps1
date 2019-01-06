import-module au

$releases = 'https://autohotkey.com/download'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*[$]fileName\s*=\s*)('.*')" = "`$1'$($Latest.FileName)'"
    }

    ".\tools\verification.txt"      = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL)"
      "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum)"
      "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum)"
      "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL)"
    }
  }
}
function global:au_BeforeUpdate {
  rm "$PSScriptRoot\tools\*.zip"
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
  Invoke-WebRequest $Latest.URL -OutFile $filePath -UseBasicParsing
  $Latest.ChecksumType = 'sha256'
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | % Hash
}

function global:au_GetLatest {
  $version_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $urls = $version_page.Links | ? href -match "^[\d\.]+\/$" | ? href -NotMatch "1\.0" | % href

  $streams = @{}
  $urls | % {
    $releasesUrl = "$releases/$_"
    $versionWithHash = Invoke-WebRequest -Uri "$releasesUrl/version.txt" -UseBasicParsing | % Content
    $version = $versionWithHash -replace '(\d+.\d+-\w+)-\w+', '$1'
    if (!$version) { $version = $versionWithHash }

    $url = "$releasesUrl/AutoHotkey_${versionWithHash}.zip"

    $key = $releasesUrl -split '\/' | select -last 1 -Skip 1
    if (!$streams.ContainsKey($key)) {
      $streams.Add($key, @{
          Version  = $version
          URL      = $url
          FileName = $url -split '/' | select -Last 1
        })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -NoCheckUrl
