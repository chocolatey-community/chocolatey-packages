Import-Module Chocolatey-AU
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = "https://versionhistory.googleapis.com/v1/chrome/platforms/win/channels/stable/versions"

function Get-MsiVersion([string]$path) {
  $installer = New-Object -ComObject WindowsInstaller.Installer
  $database = $installer.OpenDatabase($path, 0)
  $view = $database.OpenView("SELECT `Value` FROM Property WHERE Property = 'ProductVersion'")
  $view.Execute()
  $record = $view.Fetch()
  if (!$record) { throw "Unable to read ProductVersion from $path" }
  $record.StringData(1)
}

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(?i)(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.RemoteVersion)'"
    }
  }
}

function global:au_GetLatest {
  $releasesData = Invoke-RestMethod -UseBasicParsing -Method Get -Uri $releases
  $version = ($releasesData.versions | Select-Object -First 1).version

  $url32 = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise.msi'
  $msiPath = Join-Path $env:TEMP 'googlechrome-update.msi'
  try {
    Invoke-WebRequest -Uri $url32 -OutFile $msiPath -UseBasicParsing
    $msiVersion = Get-MsiVersion $msiPath
  } finally {
    Remove-Item $msiPath -Force -ErrorAction SilentlyContinue
  }
  if ($msiVersion -ne $version) {
    throw "Downloaded Google Chrome MSI version $msiVersion does not match API version $version"
  }

  @{
    URL32 = $url32
    URL64 = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    Version = Get-Version $version
    RemoteVersion = $version
    PackageName = 'GoogleChrome'
  }
}

update -ChecksumFor none
