$packageName = 'Opera'
$version = '25.0.1614.71'
$fileType = 'exe'
$installArgs = '/install /silent /launchopera 0 /setdefaultbrowser 0'
$url = 'http://get.geo.opera.com/pub/opera/desktop/25.0.1614.71/win/Opera_25.0.1614.71_Setup.exe'

try {

  $regPathModifierArray = @('Wow6432Node\', '')
  $alreadyInstalled = $null

  foreach ($regPathModifier in $regPathModifierArray) {
    $regPath = "HKLM:\SOFTWARE\${regPathModifier}Microsoft\Windows\CurrentVersion\Uninstall\Opera $version"
    if (Test-Path $regPath) {
      $alreadyInstalled = $true
    }
  }

  if ($alreadyInstalled) {
    Write-Output "Opera $version is already installed. Skipping download and installation."
  } else {
    Install-ChocolateyPackage $packageName $fileType $installArgs $url
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
