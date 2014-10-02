$saveDir = 'C:\Chocolatey\_work'
if (!(Test-Path $saveDir)) {
  mkdir $saveDir
}

$url = 'http://www.pendrivelinux.com/downloads/Universal-USB-Installer/Universal-USB-Installer-1.9.5.6.exe'
$file = Join-Path $saveDir 'universal-usb-installer.exe'

$srcUrl = $( '' +
  'http://www.pendrivelinux.com/downloads/Universal-USB-Installer/' +
  'Universal-USB-Installer-1.9.5.6-src.zip'
)

$srcFile = Join-Path $saveDir 'universal-usb-installer-src.zip'

$webClient = New-Object System.Net.WebClient

$webClient.DownloadFile($url, $file)
$webClient.DownloadFile($srcUrl, $srcFile)
