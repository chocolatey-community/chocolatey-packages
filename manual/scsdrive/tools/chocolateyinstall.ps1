$ErrorActionPreference = 'Stop'

$packageName = 'scsdrive'

# The official Inno Setup installer is downloaded and run from here.
# The checksum is the SHA-256 of the v1.1.2 win64 setup executable.
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/shuyingegit/scsdriver/releases/download/v1.1.2/scsdriver-1.1.2-setup-win64.exe'
  checksum       = 'bb1dda08846a1e1f744866ab42a41cd0f3b23b86903cf60690ea950b017102e9'
  checksumType   = 'sha256'
  softwareName   = 'ScsDrive*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
