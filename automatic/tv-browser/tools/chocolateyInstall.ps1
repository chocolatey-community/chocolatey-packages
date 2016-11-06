$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'tv-browser'
  fileType       = 'exe'
  softwareName   = 'TV-Browser*'

  checksum       = '3362f3940f92c51114330a9c496609d96ef19a25bf74181e39a4263a4442047c'
  checksumType   = 'sha256'
  url            = 'https://sourceforge.net/projects/tvbrowser/files/TV-Browser%20Releases%20%28Java%206%20and%20higher%29/3.4.4/tvbrowser_3.4.4_win32.exe/download'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
