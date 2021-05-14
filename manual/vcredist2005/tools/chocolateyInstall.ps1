$params = @{
  PackageName    = 'vcredist2005'
  FileType       = 'exe'
  Url            = 'https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE'
  Url64          = 'https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE'
  Checksum       = '8648c5fc29c44b9112fe52f9a33f80e7fc42d10f3b5b42b2121542a13e44adfd'
  Checksum64     = '4487570bd86e2e1aac29db2a1d0a91eb63361fcaac570808eb327cd4e0e2240d'
  ChecksumType   = 'sha256'
  ChecksumType64 = 'sha256'
  SilentArgs     = '/Q'
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
