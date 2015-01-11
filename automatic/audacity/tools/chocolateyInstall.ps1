try {
  $version = '{{PackageVersion}}'
  $downUrl = "http://sourceforge.net/projects/audacity/files/audacity/${version}/audacity-win-${version}.exe/download"
  # installer, will assert administrative rights
  Install-ChocolateyPackage '{{PackageName}}' 'EXE' '/VERYSILENT' "$downUrl" -validExitCodes @(0)

  # the following is all part of error handling
  Write-ChocolateySuccess '{{PackageName}}'
} catch {
  Write-ChocolateyFailure '{{PackageName}}' "$($_.Exception.Message)"
  throw
}
