Import-Module Chocolatey-AU

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
  $version_page = Invoke-RestMethod -Uri 'https://api.github.com/repos/AutoHotkey/AutoHotKey/releases'
  Write-Output "Got $($version_page.Count) versions"
  $streams = @{}
  $version_page | Where-Object -Property tag_name -Like 'v2.*' | ForEach-Object {
    $key     = $_.tag_name
    $version = $key -replace 'v'
    Write-Output "Processing version $($version)"
    if ($version -like '1.*') { continue }
    $url     = ($_.assets | Where-Object -Property name -Like '*.zip').browser_download_url
    if ($null -ne $url -and !$streams.ContainsKey($key)) {
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
