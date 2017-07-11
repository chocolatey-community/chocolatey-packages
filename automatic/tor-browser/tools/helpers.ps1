function GetDownloadsData() {
  param($filePath)

  $data = Get-Content $filePath | ConvertFrom-Csv -Delimiter '|'
  return $data
}

function GetLocaleData() {
  param($downloadData)

  $availableLocales = $downloadData | select -expand Locale

  $pp = Get-PackageParameters
  $preferredLocale = if ($pp.Locale) { $pp.Locale } else { (Get-Culture).Name }
  $twoLetterLocale = (Get-Culture).TwoLetterISOLanguageName
  $fallbackLocale = 'en-US'

  $locales = $preferredLocale,$twoLetterLocale,$fallbackLocale

  foreach ($locale in $locales) {
    $localeMatch = $availableLocales | ? { $_ -eq $locale } | select -first 1
    if (!$localeMatch -and $locale -ne $null -and $locale.Count -eq 2) {
      $localeMatch = $availableLocales | ? { ($_ -split '-' | select -first 1) -eq $locale } | select -first 1
    }
    if ($localeMatch -and $locale -ne $null) { break }
  }

  return $downloadData | ? { $_.Locale -eq $locale } | select -first 1
}

function GetDownloadInformation() {
  param($toolsPath)
  $dlData = GetDownloadsData "$toolsPath\LanguageChecksums.csv"
  if (!$dlData) { throw "No URLs is available to download from!" }
  $locale = GetLocaleData $dlData
  return $locale
}

function GetInstallDirectory() {
  param($toolsPath)

  $pp = Get-PackageParameters
  if ($pp.InstallDir) { return $pp.InstallDir }

  $binRoot = Get-ToolsLocation
  $destinationFolder = Join-Path $binRoot "tor-browser"

  if (!(Test-Path $destinationFolder)) {
    $destinationFolder = Join-Path $toolsPath "tor-browser"
  } else {
    Write-Warning @(
      'Deprecated installation folder detected (binRoot). ' +
      'This package will continue to install tor-browser there ' +
      'unless you manually remove it from "' + $destinationFolder + '".'
    )
  }

  $desktopPath = [System.Environment]::GetFolderPath('Desktop')
  $oldDestinationFolder = Join-Path $desktopPath 'Tor-Browser'
  if ((Test-Path $oldDestinationFolder) -and
      ($oldDestinationFolder -ne $destinationFolder)) {
    $destinationFolder = $oldDestinationFolder

    Write-Warning @(
      'Deprecated installation fodler detected: Desktop/Tor-Browser. ' +
      'This package will continue to install tor-browser there unless you ' +
      'remove the deprecated installation folder. After your did that, reinstall ' +
      'this package again with the "--force" parameter. Then it will be installed ' +
      'to the package tools directory.'
    )
  }

  return $destinationFolder
}
