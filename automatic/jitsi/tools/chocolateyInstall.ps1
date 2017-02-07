$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'jitsi'
  fileType               = 'MSI'
  url                    = 'https://download.jitsi.org/jitsi/msi/jitsi-2.10.5550-x86.msi'
  url64bit               = 'https://download.jitsi.org/jitsi/msi/jitsi-2.10.5550-x64.msi'
  checksum               = 'f0aabb9f32e93183d6845f5b5d9e2f1f8b531133c92f3a26bf539a87f16b4572'
  checksum64             = 'cf0afa658974af2ffc2683497419ba03a68448d69d3f972b0d29c89c629d0442'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
