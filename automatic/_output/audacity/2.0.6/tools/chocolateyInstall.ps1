try {
  $version = '2.0.6'
  $downUrl = "http://sourceforge.net/projects/audacity/files/audacity/${version}/audacity-win-${version}.exe/download"
  # installer, will assert administrative rights
  Install-ChocolateyPackage 'audacity' 'EXE' '/SILENT' "$downUrl" -validExitCodes @(0)

  # the following is all part of error handling
  Write-ChocolateySuccess 'audacity'
} catch {
  Write-ChocolateyFailure 'audacity' "$($_.Exception.Message)"
  throw
}
