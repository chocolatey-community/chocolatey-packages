param(
    [string]$package = ""
    )

if ($package -eq "" -or $package -eq $null) {
  Write-Warning 'Please specify a package or list of packages. Run -help or /? for more information.'
}
elseif ($package -eq '-help' -or $package -eq '/?') {
  Write-Host "To run please specify `'cyg-get packageName`'. At the current time it doesn't appear that passing a list of packages works, but it would be done like this: `'cyg-get package1,package2,packageN`'. Note the commas and no spaces."
}
else {
  try {
    Set-Location -Path (Get-ItemProperty HKLM:\SOFTWARE\Cygwin\setup -Name rootdir).rootdir
    $cygwinsetup = Get-Command cygwinsetup.exe
    $cygRoot = Split-Path -parent $cygwinsetup.Path
    $cygPackages = join-path $cygRoot packages

    Write-Host "Attempting to install `'$package`' to `'$cygPackages`'"
    & $cygwinsetup -q -N -R $cygRoot -l $cygPackages -s ftp://mirrors.kernel.org/sourceware/cygwin -P $package
  }
  catch {
    Write-Error "Please ensure you have cygwin installed (with chocolatey). To install please call 'cinst cygwin'. ERROR: $($_.Exception.Message)"
  }
}
