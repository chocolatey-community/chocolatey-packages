$ErrorActionPreference = 'STOP'

# remove python3.x shim
$minor_version = $env:ChocolateyPackageName.Substring('python3'.Length)
Uninstall-BinFile "python3.$minor_version"
