Function matchLanguage($availableLangs, $installOverride = '', $ofExistentInstall = '', $fallback = 'en-US') {

  $detectedLangs = @{
    installOverride = $installOverride
    ofExistentInstall = $ofExistentInstall
    winUiOverride = $null
    listFirst = $null
    fromCulture = $null
    fallback = $fallback
  }

  $detectedLangsOrder = @('installOverride', 'ofExistentInstall', 'winUiOverride', 'listFirst', 'fromCulture', 'fallback')

  # Get get language override for user account if present. Overriding the language is possible from the control panel
  if (Get-Command Get-WinUILanguageOverride -ErrorAction SilentlyContinue) {
    $detectedLangs.winUiOverride = (Get-WinUILanguageOverride).Name
  }

  # Get the first language from the user account language list. If the language override is not set, this is the
  # actual language of the current user account
  if (Get-Command Get-WinUserLanguageList -ErrorAction SilentlyContinue) {
    $detectedLangs.listFirst = (Get-WinUserLanguageList)[0].LanguageTag
  }

  # The language from Get-Culture is not the actual UI language, only the locale format. I use this because on Windows 7
  # there seems no other possibility to get the system or user UI language.
  $detectedLangs.fromCulture = (Get-Culture).Name

  # Loop over detected languages and for each detected language, loop over the available language
  # and return the first matched language
  foreach ($key in $detectedLangsOrder) {

    $langTwoLetter = $detectedLangs[$key] -replace "-[A-Z]+", ''

    foreach ($availableLang in $availableLangs) {

      if ($detectedLangs[$key] -contains $availableLang) {
        return $availableLang
      }

      if ($langTwoLetter -contains $availableLang) {
        return $availableLang
      }
    }
  }
}
