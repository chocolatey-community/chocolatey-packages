Import-Module Chocolatey-AU

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
  Remove-Item "$PSScriptRoot\tools\*.zip"
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
  Invoke-WebRequest $Latest.URL -OutFile $filePath -UseBasicParsing
  $Latest.ChecksumType = 'sha256'
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | ForEach-Object Hash
}

function global:au_GetLatest {
  $version_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $urls = $version_page.Links | Where-Object href -match "^[\d\.]+\/$" | Where-Object href -NotMatch "1\.0" | ForEach-Object href

  $streams = @{}
  $urls | ForEach-Object {
    $releasesUrl = "$releases/$_"
    $versionWithHash = Invoke-WebRequest -Uri "$releasesUrl/version.txt" -UseBasicParsing | ForEach-Object Content
    $version = $versionWithHash -replace '(\d+.\d+-\w+)-\w+', '$1'
    $version = $version -replace '(-\w+)\.', '$1'
    if (!$version) { $version = $versionWithHash }

    $url = "$releasesUrl/AutoHotkey_${versionWithHash}.zip"

    $key = $releasesUrl -split '\/' | Select-Object -last 1 -Skip 1
    if (!$streams.ContainsKey($key)) {
      $streams.Add($key, @{
          Version  = $version
          URL      = $url
          FileName = $url -split '/' | Select-Object -Last 1
        })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -NoCheckUrl
