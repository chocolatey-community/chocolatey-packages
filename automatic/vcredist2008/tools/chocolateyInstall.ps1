$params = @{
  PackageName    = 'vcredist2008'
  FileType       = 'exe'
  Url            = 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe'
  Url64          = 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe'
  Checksum       = '8742bcbf24ef328a72d2a27b693cc7071e38d3bb4b9b44dec42aa3d2c8d61d92'
  Checksum64     = 'c5e273a4a16ab4d5471e91c7477719a2f45ddadb76c7f98a38fa5074a6838654'
  ChecksumType   = 'sha256'
  ChecksumType64 = 'sha256'
  SilentArgs     = '/Q /NORESTART'
  ValidExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
}
Install-ChocolateyPackage @params

# Install both 32bit and 64bit on a 64bit OS
# If a program is compiled as x86 and the 32bit version of vcredist isn't installed, then the program would fail to start.
if (Get-ProcessorBits 64 -and ($env:chocolateyForceX86 -ne $true)) {
  $originalChocolateyForceX86 = $Env:chocolateyForceX86
  $Env:chocolateyForceX86 = $true
  Install-ChocolateyPackage @params
  $Env:chocolateyForceX86 = $originalChocolateyForceX86
}
