$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'jitsi'
  fileType               = 'MSI'
  url                    = 'https://download.jitsi.org/jitsi/msi/jitsi-2.8.5426-x86.msi'
  url64bit               = 'https://download.jitsi.org/jitsi/msi/jitsi-2.8.5426-x64.msi'
  checksum               = '015de91cf5c89335908b17020bddfae436e6cf8bcb490f3ddc8183fb20d195ee'
  checksum64             = 'da8a85a039e62ef4563c3d576c4d2e12ed84db29bfd1bcec8b0e523776a5b358'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
