import-module au

$releases = 'https://www.piriform.com/ccleaner/download/standard'

function global:au_BeforeUpdate {
  $tmpFile = "$env:TEMP\ccleaner.exe"
  Invoke-WebRequest -Uri $Latest.URL32 -OutFile $tmpFile -UseBasicParsing

  $Latest.Checksum32 = Get-FileHash $tmpFile -Algorithm $Latest.ChecksumType32 | % Hash
  [version]$fileVersion = Get-Item $tmpFile | % { $_.VersionInfo.FileVersion }

  if ($fileVersion.ToString(2) -ne $Latest.RemoteVersion.ToString(2)) {
    # We only care about major and minor parts
    throw "Executable have not yet been updated"
  }

  rm $tmpFile -Force
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url = $download_page.links | ? href -match $re | select -First 1 -expand href

  $download_page = Invoke-WebRequest https://www.piriform.com/ccleaner/version-history -UseBasicParsing
  $Matches = $null
  $download_page.Content -match "\<h6\>v((?:[\d]\.)[\d\.]+)"
  $version = $Matches[1]

  @{ URL32 = $url -replace 'http:', 'https:'; Version = $version ; RemoteVersion = [version]$version ; ChecksumType32 = 'sha256' }
}

update -ChecksumFor none
