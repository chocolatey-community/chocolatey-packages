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
