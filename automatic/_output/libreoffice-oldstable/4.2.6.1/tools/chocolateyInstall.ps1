$packageName = 'libreoffice-oldstable'
$downUrl = 'http://download.documentfoundation.org/libreoffice/stable/4.2.6/win/x86/LibreOffice_4.2.6-secfix_Win_x86.msi'
try {

  Install-ChocolateyPackage $packageName 'msi' '/passive /norestart' $downUrl -validExitCodes @(0)

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
