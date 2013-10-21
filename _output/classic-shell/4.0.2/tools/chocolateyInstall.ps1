$packageName = 'classic-shell'
$installerType = 'exe'
$silentArgs = '/passive'

$language = (Get-Culture).TwoLetterISOLanguageName
if ($language -eq 'ru') {
    $url = 'http://www.classicshell.net/downloads/latestru'
} else {
    $url = 'http://www.classicshell.net/downloads/latest'
}

Install-ChocolateyPackage $packageName $installerType $silentArgs $url