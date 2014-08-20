$packageName = 'GoogleChrome'
$fileType = 'msi'
$silentArgs = '/quiet'
$url = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B00000000-0000-0000-0000-000000000000%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url