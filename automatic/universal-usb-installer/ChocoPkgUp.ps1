$url = '{{DownloadUrl}}'
$file = '.\tools\universal-usb-installer.exe'

$srcUrl = $( '' +
    'http://www.pendrivelinux.com/downloads/Universal-USB-Installer/' +
    'Universal-USB-Installer-{{PackageVersion}}-src.zip'
)

$srcFile = '.\tools\universal-usb-installer-src.zip'

$webClient = New-Object System.Net.WebClient

$webClient.DownloadFile($url, $file)
$webClient.DownloadFile($srcUrl, $srcFile)
