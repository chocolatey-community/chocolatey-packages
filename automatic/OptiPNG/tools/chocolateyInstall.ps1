try {
  $package = 'OptiPNG'
  $installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

  $zipUrl = 'http://sourceforge.net/projects/optipng/files/OptiPNG/optipng-0.7.5/optipng-0.7.5-win32.zip/download'

  Install-ChocolateyZipPackage $package "$zipUrl" "$installDir"

  Move-Item -Path "$($installDir)\optipng-0.7.5-win32\*" -Destination "$installDir" -Force
  Remove-Item "$($installDir)\optipng-0.7.5-win32"

} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}

