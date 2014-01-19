$packageName = 'classic-shell'
$installerType = 'exe'
$installArguments = '/passive'

$language = (Get-Culture).TwoLetterISOLanguageName
if ($language -eq 'ru') {
    $url = 'http://www.classicshell.net/downloads/latestru'
} else {
    $url = 'http://www.classicshell.net/downloads/latest'
}

Install-ChocolateyPackage $packageName $installerType $installArguments $url