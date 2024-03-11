Import-Module Chocolatey-AU

$releases = 'https://www.ccleaner.com/ccleaner/download/standard'

function global:au_BeforeUpdate {
  $tmpFile = "$env:TEMP\ccleaner.exe"
  Invoke-WebRequest -Uri $Latest.URL32 -OutFile $tmpFile -UseBasicParsing

  $Latest.Checksum32 = Get-FileHash $tmpFile -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash
  [version]$fileVersion = Get-Item $tmpFile | ForEach-Object { $_.VersionInfo.FileVersion }

  if ($fileVersion.ToString(2) -ne $Latest.RemoteVersion.ToString(2)) {
    # We only care about major and minor parts
    throw 'Executable have not yet been updated'
  }

  Remove-Item $tmpFile -Force
}

function global:au_SearchReplace {
  @{
    '.\tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest 'https://www.ccleaner.com/auto?p=cc' -UseBasicParsing
  $version = $download_page.Content.Split('|')[2]

  $url = 'https://download.ccleaner.com/ccsetup{0}.exe' -f ($version -replace '^(\d+)\.(\d+).*$', '$1$2')

  @{ URL32 = $url -replace 'http:', 'https:'; Version = $version ; RemoteVersion = [version]$version ; ChecksumType32 = 'sha256' }
}

update -ChecksumFor none
