$saveDir = 'C:\Chocolatey\_work'
if (!(Test-Path $saveDir)) {
  mkdir $saveDir
}

$url = '{{DownloadUrl}}'
$file = 'yumi.exe'
$filePath = Join-Path $saveDir $file

$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($url, $filePath)
