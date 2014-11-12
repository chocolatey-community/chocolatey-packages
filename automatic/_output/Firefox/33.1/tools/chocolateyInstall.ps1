# ---------------- Function definitions ------------------


function GetUninstallPath () {
  $regUninstallDir = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
  $regUninstallDirWow64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'

  $uninstallPaths = $(Get-ChildItem $regUninstallDir).Name

  if (Test-Path $regUninstallDirWow64) {
    $uninstallPaths += $(Get-ChildItem $regUninstallDirWow64).Name
  }

  $uninstallPath = $uninstallPaths -match "Mozilla Firefox [\d\.]+ \([^\s]+ [a-zA-Z\-]+\)" | Select -First 1
  return $uninstallPath
}

function GetLocale($installArguments) {

  $availableLocales = Get-Content "$env:TEMP\chocolatey\Firefox\availableLocales.html"

  # --- Get locale from installArgs if specified

  $argumentMap = ConvertFrom-StringData $installArguments
  $localeFromInstallArgs = $argumentMap.Item('l')

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

  $locales = $localeFromInstallArgs, $alreadyInstalledLocale, $systemLocaleAndCountry, $systemLocaleTwoLetter, $fallbackLocale

  foreach ($locale in $locales) {
    $localeMatch = $availableLocales -match "os=win&amp;lang=$locale`"" | Select -First 1
    if ($localeMatch -and $locale -ne $null) {
      break
    }
  }

  return $locale
}

function AlreadyInstalled($version) {
  $uninstallEntry = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Firefox ${version}*"
  $uninstallEntryWow64 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Firefox ${version}*"

  if ((Test-Path $uninstallEntry) -or (Test-Path $uninstallEntryWow64)) {
    return $true
  } else {
    return $false
  }
}

# ----------------------------------




$packageName = 'Firefox'
$fileType = 'exe'
$version = '33.1'

$urlFile = 'https://www.mozilla.org/en-US/firefox/all/'
$filePath = "$env:TEMP\chocolatey\$packageName"

try {
    $alreadyInstalled = AlreadyInstalled($version)

  if ($alreadyInstalled) {
    Write-Host "Firefox $version is already installed."
  } else {


    if (-not (Test-Path $filePath)) {
      New-Item -ItemType directory -Path $filePath
    }

    Get-ChocolateyWebFile 'locales list for Firefox' "$env:TEMP\chocolatey\$packageName\availableLocales.html" $urlFile

    $locale = GetLocale($installArguments)


    $url = "http://download.mozilla.org/?product=firefox-$version&os=win&lang=$locale"


    Install-ChocolateyPackage $packageName $fileType '-ms' $url
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
