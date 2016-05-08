# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.

$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'

$softwareNameLowerCase = $packageName.ToLower()

$softwareNameTitleCase = $packageName.Substring(0, 1).ToUpper() +
  $packageName.Substring(1).ToLower()

$allLocalesListURL = Switch ($softwareNameLowerCase) {
  'firefox' {
    'https://www.mozilla.org/en-US/firefox/all/'
    break
  }

  'thunderbird' {
    'https://www.mozilla.org/en-US/thunderbird/all/'
    break
  }
}



# ---------------- Function definitions ------------------


function GetUninstallPath () {
  $regUninstallDir = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
  $regUninstallDirWow64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'

  $uninstallPaths = $(Get-ChildItem $regUninstallDir).Name

  if (Test-Path $regUninstallDirWow64) {
    $uninstallPaths += $(Get-ChildItem $regUninstallDirWow64).Name
  }

  $uninstallPath = $uninstallPaths -match "Mozilla $softwareNameTitleCase [\d\.]+ \([^\s]+ [a-zA-Z\-]+\)" | Select -First 1
  return $uninstallPath
}

function GetLocale() {

  $availableLocales = (New-Object System.Net.WebClient).DownloadString($allLocalesListURL)

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
  $uninstallEntry = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla $softwareNameTitleCase ${version}*"
  $uninstallEntryWow64 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla $softwareNameTitleCase ${version}*"

  if ((Test-Path $uninstallEntry) -or (Test-Path $uninstallEntryWow64)) {
    return $true
  } else {
    return $false
  }
}

# ----------------------------------

$alreadyInstalled = AlreadyInstalled($version)

if ($alreadyInstalled) {
  Write-Output $(
    "$softwareNameTitleCase $version is already installed. "
    'No need to download an re-install again.'
  )
} else {

  $locale = GetLocale

  $url = "https://download.mozilla.org/?product=${softwareNameLowerCase}-${version}&os=win&lang=${locale}"
  $silentArgs = '-ms'

  Install-ChocolateyPackage $packageName $fileType $silentArgs $url
}
