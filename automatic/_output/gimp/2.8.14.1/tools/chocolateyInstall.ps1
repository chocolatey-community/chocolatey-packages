$packageName = 'gimp'
$url = 'http://gimper.net/downloads/pub/gimp/stable/windows/gimp-2.8.14-setup-1.exe'
$installerType = 'exe'
$installArgs = 'SP- /SILENT /NORESTART'


try {

  # This makes sure that GMIP 2.8.14-fix (from 2014-09-2) is installed
  Install-ChocolateyPackage $packageName $installerType $installArgs $url -validExitCodes @(0)

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
