$packageName = '{{PackageName}}'

# We know that using Win32_Product is bad.
# Is there a better alternative to check if it’s
# already installed?
$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -eq 'Brackets'}
if ($app) {
  $msiArgs = $('/x' + $app.IdentifyingNumber + ' /q REBOOT=ReallySuppress')
  Start-ChocolateyProcessAsAdmin $msiArgs 'msiexec'
}
