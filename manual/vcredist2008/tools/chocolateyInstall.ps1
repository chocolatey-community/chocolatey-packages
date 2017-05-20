$params = @{
  PackageName   = 'vcredist2008'
  FileType      = 'exe'
  Url           = 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe'
  Url64bit      = 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe'
  Checksum      = '470640aa4bb7db8e69196b5edb0010933569e98d'
  Checksum64    = 'a7c83077b8a28d409e36316d2d7321fa0ccdb7e8'
  ChecksumType  = "sha1"
  ChecksumType64= 'sha1'
  SilentArgs    = '/Q'
  ValidExitCodes= @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
} 
Install-ChocolateyPackage @params

# Install both 32bit and 64bit on a 64bit OS
# If a program is compiled as x86 and the 32bit version of vcredist isn't installed, then the program would fail to start.
if (Get-ProcessorBits 64) { $Env:chocolateyForceX86 = $true; Install-ChocolateyPackage @params }