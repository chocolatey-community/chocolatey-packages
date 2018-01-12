function GetUninstallPath() {
  param(
    [Parameter(Mandatory = $true)]
    [string]$product
  )
  $regUninstallDir = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
  $regUninstallDirWow64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'

  $uninstallPaths = $(Get-ChildItem $regUninstallDir).Name

  if (Test-Path $regUninstallDirWow64) {
    $uninstallPaths += $(Get-ChildItem $regUninstallDirWow64).Name
  }

  $uninstallPath = $uninstallPaths -match "$product [\d\.]+ \([^\s]+ [a-zA-Z\-]+\)" | select -first 1
  return $uninstallPath
}

function GetLocale {
  param(
    [Parameter(Mandatory = $true)]
    [string]$localeFile,
    [Parameter(Mandatory = $true)]
    [string]$product
  )
  #$availableLocales = Get-WebContent $localeUrl 2>$null
  $availableLocales = Get-Content $localeFile | % { $_ -split '\|' | select -first 1 } | select -Unique

  $packageParameters = $env:chocolateyPackageParameters

  $packageParameters = if ($packageParameters -ne $null) { $packageParameters } else { "" }

  $argumentMap = ConvertFrom-StringData $packageParameters
  $localeFromPackageParameters = $argumentMap.Item('l')

  $uninstallPath = GetUninstallPath -product $product

  $alreadyInstalledLocale = $uninstallPath -replace ".+\s([a-zA-Z\-]+)\)",'$1'

  $systemLocalizeAndCountry = (Get-Culture).Name
  $systemLocaleTwoLetter = (Get-Culture).TwoLetterISOLanguageName
  $fallbackLocale = 'en-US'

  $locales = $localeFromPackageParameters, $alreadyInstalledLocale, `
    $systemLocalizeAndCountry, $systemLocaleTwoLetter, $fallbackLocale

    foreach ($locale in $locales) {
      $localeMatch = $availableLocales | ? { $_ -eq $locale } | select -first 1
      if ($localeMatch -and $locale -ne $null) {
        break
      }
    }

    return $locale
}

function AlreadyInstalled() {
  param(
    [Parameter(Mandatory = $true)]
    [string]$product,
    [Parameter(Mandatory = $true)]
    [string]$version
  )
  $uninstallEntry = $(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$product $version*"
  )
  $uninstallEntryWow64 = $(
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$product $version*"
  )

  if ((Test-Path $uninstallEntry) -or (Test-Path $uninstallEntryWow64)) {
    return $true
  }

  return $false
}

function Get-32bitOnlyInstalled() {
  param(
    [Parameter(Mandatory = $true)]
    [string]$product
  )
  $systemIs64bit = Get-ProcessorBits 64

  if (-Not $systemIs64bit) {
    return $false
  }

  $registryPaths = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
  )

  $installedVersions = Get-ChildItem $registryPaths | ? { $_.Name -match "$product [\d\.]+ \(x(64|86)" }

  if (
    $installedVersions -match 'x86' `
    -and $installedVersions -notmatch 'x64' `
    -and $systemIs64bit
  ) {
    return $true
  }
}

function GetChecksums() {
  param(
    [Parameter(Mandatory = $true)]
    [string]$language,
    [Parameter(Mandatory = $true)]
    $checksumFile
  )
  Write-Debug "Loading checksums from: $checksumFile"
  $checksumContent = Get-Content $checksumFile
  $checksum32 = ($checksumContent -match "$language\|32") -split '\|' | select -last 1
  $checksum64 = ($checksumContent -match "$language\|64") -split '\|' | select -last 1

  return @{
    "Win32" = $checksum32
    "Win64" = $checksum64
  }
}
