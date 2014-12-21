$saveDir = 'C:\Chocolatey\_work'
if (!(Test-Path $saveDir)) {
  mkdir $saveDir
}

$url = '{{DownloadUrl}}'
$file = Join-Path $saveDir 'universal-usb-installer.exe'

$srcUrl = $( '' +
  'http://www.pendrivelinux.com/downloads/Universal-USB-Installer/' +
  'Universal-USB-Installer-{{PackageVersion}}-src.zip'
)

$srcFile = Join-Path $saveDir 'universal-usb-installer-src.zip'

$webClient = New-Object System.Net.WebClient

$webClient.DownloadFile($url, $file)
$webClient.DownloadFile($srcUrl, $srcFile)
