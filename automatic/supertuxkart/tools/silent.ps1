$process = ''

while (!($process)) {
Start-Sleep -Milliseconds 500
$process = Get-Process | Where-Object {$_.ProcessName -eq 'vcredist_x86'}
#Start-Sleep -Milliseconds 500
if ($process) {Stop-Process -ProcessName 'vcredist_x86'}
}

$process = ''

while (!($process)) {
Start-Sleep -Milliseconds 500
$process = Get-Process | Where-Object {$_.ProcessName -eq 'oalinst'}
#Start-Sleep -Milliseconds 500
if ($process) {Stop-Process -ProcessName 'oalinst'}
}
