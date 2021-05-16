$params = @{
  PackageName    = 'vcredist2010'
  FileType       = 'exe'
  Url            = 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe'
  Url64          = 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe'
  Checksum       = '99dce3c841cc6028560830f7866c9ce2928c98cf3256892ef8e6cf755147b0d8'
  Checksum64     = 'f3b7a76d84d23f91957aa18456a14b4e90609e4ce8194c5653384ed38dada6f3'
  ChecksumType   = 'sha256'
  ChecksumType64 = 'sha256'
  SilentArgs     = '/Q /NORESTART'
  ValidExitCodes = @(0,3010) # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
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
