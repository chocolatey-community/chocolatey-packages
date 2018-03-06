$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'tv-browser'
  fileType       = 'exe'
  softwareName   = 'TV-Browser*'

  checksum       = '84859d71ac6829bf28e19aff727b66cb3979c167c07c20a6b2db4294db6b2725'
  checksumType   = 'sha256'
  url            = 'https://sourceforge.net/projects/tvbrowser/files/TV-Browser%20Releases%20%28Java%208%20and%20higher%29/4.0.1/tvbrowser_4.0.1_win32.exe/download'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
