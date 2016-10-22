# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.

$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'

$allLocalesListURL = 'https://www.mozilla.org/en-US/firefox/all/'



# ---------------- Function definitions ------------------


function GetUninstallPath () {
  $regUninstallDir = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
  $regUninstallDirWow64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'

  $uninstallPaths = $(Get-ChildItem $regUninstallDir).Name

  if (Test-Path $regUninstallDirWow64) {
    $uninstallPaths += $(Get-ChildItem $regUninstallDirWow64).Name
  }

  $uninstallPath = $uninstallPaths -match
    "Mozilla Firefox [\d\.]+ \([^\s]+ [a-zA-Z\-]+\)" | Select -First 1
  return $uninstallPath
}

function GetLocale() {

  $webclient = New-Object System.Net.WebClient
  $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
  $proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
  $webclient.Proxy = $proxy

  $availableLocales = $webclient.DownloadString($allLocalesListURL)

  # --- Get locale from installArgs if specified

  $packageParameters = $env:chocolateyPackageParameters

  $packageParameters = if ($packageParameters -ne $null) { $packageParameters } else { "" }
  $argumentMap = ConvertFrom-StringData $packageParameters
  $localeFromPackageParameters = $argumentMap.Item('l')

  # ---

  # --- Get already installed locale if available

  $uninstallPath = GetUninstallPath($null)

  $alreadyInstalledLocale = $uninstallPath -replace ".+\s([a-zA-Z\-]+)\)", '$1'


  # ---

  # --- Other locales

  $systemLocaleAndCountry = (Get-Culture).Name
  $systemLocaleTwoLetter = (Get-Culture).TwoLetterISOLanguageName
  $fallbackLocale = 'en-US'

  # ---

  $locales = $localeFromPackageParameters, $alreadyInstalledLocale, `
    $systemLocaleAndCountry, $systemLocaleTwoLetter, $fallbackLocale

  foreach ($locale in $locales) {
    $localeMatch = $availableLocales -match "os=win&amp;lang=$locale`"" | Select -First 1
    if ($localeMatch -and $locale -ne $null) {
      break
    }
  }

  return $locale
}


function AlreadyInstalled($version) {
  $uninstallEntry = $(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla " +
    "Firefox ${version}*"
  )
  $uninstallEntryWow64 = $(
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla " +
    "Firefox ${version}*"
  )

  if ((Test-Path $uninstallEntry) -or (Test-Path $uninstallEntryWow64)) {
    return $true
  }

  return $false
}

function Get-32bitOnlyInstalled {
  $systemIs64bit = Get-ProcessorBits 64
  
  if (-Not $systemIs64bit) {
    return $false
  }

  $registryPaths = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
  )

  $installedVersions = Get-ChildItem $registryPaths | Where-Object {
    $_.Name -match 'Mozilla Firefox [\d\.]+ \(x(64|86)'
  }

  if (
    $installedVersions -match 'x86' `
    -and $installedVersions -notmatch 'x64' `
    -and $systemIs64bit
  ) {
    return $true
  }
}

# ----------------------------------

$alreadyInstalled = AlreadyInstalled($version)

if (Get-32bitOnlyInstalled) {
  Write-Output $(
    'Detected the 32-bit version of Firefox on a 64-bit system. ' +
    'This package will continue to install the 32-bit version of Firefox ' +
    'unless the 32-bit version is uninstalled.'
  )
}

if ($alreadyInstalled) {
  Write-Output $(
    "Firefox $version is already installed. " +
    'No need to download an re-install again.'
  )
} else {

  $locale = GetLocale

  $url = "https://download.mozilla.org/?product=firefox-${version}&os=win&lang=${locale}"
  $url64 = "https://download.mozilla.org/?product=firefox-${version}-SSL&os=win64&lang=${locale}"
  $silentArgs = '-ms'

  if ((Get-32bitOnlyInstalled) -or (Get-ProcessorBits 32)) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  } else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
  }

}
