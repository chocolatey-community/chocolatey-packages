param(
    [string]$package = ""
    )

if ($package -eq "" -or $package -eq $null) {
  Write-Warning 'Please specify a package or list of packages. Run -help or /? for more information.'
}
elseif ($package -eq '-help' -or $package -eq '--help' -or $package -eq '-h' -or $package -eq '/?') {
  Write-Host "To run please specify `'cyg-get packageName`'. You can also specify a list of packages like this: `'cyg-get package1,package2,packageN`'. Note the commas and no spaces."
}
else {
  try {
    $cygRoot = (Get-ItemProperty HKLM:\SOFTWARE\Cygwin\setup -Name rootdir).rootdir
    $cygwinsetup = Get-Command $cygRoot"\cygwinsetup.exe"
    $cygLocalPackagesDir = join-path $cygRoot packages
    $cygInstallPackageList = $package  -replace(" ",",")

    Write-Host "Attempting to install cygwin packages: $cygInstallPackageList"
    & $cygwinsetup -q -N -R $cygRoot -l $cygLocalPackagesDir -P $cygInstallPackageList
  }
  catch {
    Write-Error "Please ensure you have cygwin installed (with chocolatey). To install please call 'cinst cygwin'. ERROR: $($_.Exception.Message)"
  }
}
