Import-Module Chocolatey-AU
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = "https://versionhistory.googleapis.com/v1/chrome/platforms/win/channels/stable/versions"
$paddedUnderVersion = '57.0.2988'

function Get-MsiProductVersion {
  param(
    [Parameter(Mandatory = $true)]
    [string]$MsiPath
  )

  $installer = $null
  $database = $null
  $view = $null
  $record = $null

  try {
    $installer = New-Object -ComObject WindowsInstaller.Installer
    $database = $installer.GetType().InvokeMember(
      'OpenDatabase',
      [System.Reflection.BindingFlags]::InvokeMethod,
      $null,
      $installer,
      @($MsiPath, 0)
    )
    $view = $database.GetType().InvokeMember(
      'OpenView',
      [System.Reflection.BindingFlags]::InvokeMethod,
      $null,
      $database,
      @("SELECT `Value` FROM `Property` WHERE `Property`='ProductVersion'")
    )
    $null = $view.GetType().InvokeMember(
      'Execute',
      [System.Reflection.BindingFlags]::InvokeMethod,
      $null,
      $view,
      $null
    )
    $record = $view.GetType().InvokeMember(
      'Fetch',
      [System.Reflection.BindingFlags]::InvokeMethod,
      $null,
      $view,
      $null
    )

    if ($null -eq $record) {
      throw "Could not read ProductVersion from '$MsiPath'."
    }

    $productVersion = $record.GetType().InvokeMember(
      'StringData',
      [System.Reflection.BindingFlags]::GetProperty,
      $null,
      $record,
      @(1)
    )

    if ([string]::IsNullOrWhiteSpace($productVersion)) {
      throw "MSI ProductVersion is empty for '$MsiPath'."
    }

    return $productVersion
  }
  finally {
    foreach ($comObject in @($record, $view, $database, $installer)) {
      if ($null -ne $comObject -and [System.Runtime.InteropServices.Marshal]::IsComObject($comObject)) {
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($comObject)
      }
    }
  }
}

function Get-FileSha256 {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Path
  )

  (Get-FileHash -Path $Path -Algorithm SHA256).Hash
}

function global:au_BeforeUpdate {
  $downloadPath32 = Join-Path $env:TEMP "googlechrome32-$PID.msi"
  $downloadPath64 = Join-Path $env:TEMP "googlechrome64-$PID.msi"

  try {
    Invoke-WebRequest -UseBasicParsing -Method Get -Uri $Latest.URL64 -OutFile $downloadPath64
    $msiVersion = Get-MsiProductVersion -MsiPath $downloadPath64

    if ($Latest.RemoteVersion -ne $msiVersion) {
      throw "Version mismatch: API returned '$($Latest.RemoteVersion)' but MSI contains '$msiVersion'."
    }

    $Latest.RemoteVersion = $msiVersion
    $Latest.Checksum64 = Get-FileSha256 -Path $downloadPath64

    Invoke-WebRequest -UseBasicParsing -Method Get -Uri $Latest.URL32 -OutFile $downloadPath32
    $Latest.Checksum32 = Get-FileSha256 -Path $downloadPath32
  }
  finally {
    Remove-Item -Path $downloadPath32 -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $downloadPath64 -Force -ErrorAction SilentlyContinue
  }
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
  
  @{
    URL32 = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise.msi'
    URL64 = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    Version = Get-FixVersion $version -OnlyFixBelowVersion $paddedUnderVersion
    RemoteVersion = $version
    PackageName = 'GoogleChrome'
  }
}

update -ChecksumFor none
