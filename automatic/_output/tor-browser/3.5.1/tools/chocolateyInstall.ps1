$packageName = 'tor-browser'
$installerType = 'exe'
$silentArgs = '/S'

try {

    $language = (Get-Culture).Name -replace '-[a-z]{2}', '' # get language code
    #$language = 'xx' # Language override for testing

    $table = @{
    'en' = 'en-US';
    'ar' = 'ar';
    'de' = 'de';
    'es' = 'es-ES';
    'fa' = 'fa';
    'fr' = 'fr';
    'it' = 'it';
    'nl' = 'nl';
    'pl' = 'pl';
    'pt' = 'pt-PT';
    'ru' = 'ru';
    'vi' = 'vi';
    'zh' = 'zh-CN';
    }

    $langcode = $table[$language]
    # English = fallback language
    if ($langcode -eq $null) {$langcode = 'en-US'}

    # DownloadUrlx64 gets “misused” here as variable for the real version with  hyphen
    $url = "https://www.torproject.org/dist/torbrowser/3.5.1/torbrowser-install-3.5.1_${langcode}.exe"

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}

Install-ChocolateyPackage $packageName $installerType $silentArgs $url