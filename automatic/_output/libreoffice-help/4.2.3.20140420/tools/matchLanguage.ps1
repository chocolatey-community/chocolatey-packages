Function matchLanguage($availableLangs, $installOverride = '', $ofExistentInstall = '', $fallback = 'en-US') {

    $detectedLangs = @{
        installOverride = $installOverride
        ofExistentInstall = $ofExistentInstall
        winUiOverride = ''
        listFirst = ''
        fallback = $fallback
    }

    $detectedLangsOrder = @('installOverride', 'ofExistentInstall', 'winUiOverride', 'listFirst', 'fallback')

    # Get get language override for user account if present. Overriding the language is possible from the control panel
    if (Get-WinUILanguageOverride) {
        $detectedLangs.winUiOverride = Get-WinUILanguageOverride.Name
    }

    # Get the first language from the user account language list. If the language override is not set, this is the
    # actual language of the current user account
    $detectedLangs.listFirst = (Get-WinUserLanguageList)[0].LanguageTag

    # Loop over detected languages and for each detected language, loop over the available language
    # and return the first matched language
    foreach ($key in $detectedLangsOrder) {

        $langTwoLetter = $detectedLangs[$key] -replace "-[A-Z]+", ''

        foreach ($availableLang in $availableLangs) {

            if ($availableLang -ieq $detectedLangs[$key]) {
                return $availableLang
            }

            if ($availableLang -ieq $langTwoLetter) {
                return $availableLang
            }
        }
    }
}
