$packageName = '{{PackageName}}'

try {

  $app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -eq 'Google Chrome'}
  if ($app) {
    $msiArgs = $('/x' + $app.IdentifyingNumber + ' /q REBOOT=ReallySuppress')
    Start-ChocolateyProcessAsAdmin $msiArgs 'msiexec'
  }

  Write-ChocolateySuccess $packageName


} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
