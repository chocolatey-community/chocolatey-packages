$url = '{{DownloadUrl}}'
$file = '.\tools\yumi.exe'

$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($url, $file)
