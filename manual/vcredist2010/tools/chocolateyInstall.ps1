$params = @{
  PackageName    = 'vcredist2010'
  FileType       = 'exe'
  Url            = 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe'
  Url64          = 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe'
  Checksum       = '67313B3D1BC86E83091E8DE22981F14968F1A7FB12EB7AD467754C40CD94CC3D'
  Checksum64     = 'CC7EC044218C72A9A15FCA2363BAED8FC51095EE3B2A7593476771F9EBA3D223'
  ChecksumType   = 'sha256'
  ChecksumType64 = 'sha256'
  SilentArgs     = '/Q /NORESTART'
  ValidExitCodes = @(0,3010) # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
}
Install-ChocolateyPackage @params

# Install both 32bit and 64bit on a 64bit OS
# If a program is compiled as x86 and the 32bit version of vcredist isn't installed, then the program would fail to start.
if (Get-ProcessorBits 64) {
  $originalChocolateyForceX86 = $Env:chocolateyForceX86
  $Env:chocolateyForceX86 = $true
  Install-ChocolateyPackage @params
  $Env:chocolateyForceX86 = $originalChocolateyForceX86
}
