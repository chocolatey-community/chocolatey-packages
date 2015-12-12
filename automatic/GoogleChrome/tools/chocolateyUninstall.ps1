$packageName = '{{PackageName}}'

$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -eq 'Google Chrome'}
if ($app) {
  $msiArgs = $('/x' + $app.IdentifyingNumber + ' /q REBOOT=ReallySuppress')
  Start-ChocolateyProcessAsAdmin $msiArgs 'msiexec'
}
