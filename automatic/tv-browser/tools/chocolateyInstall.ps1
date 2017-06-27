$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'tv-browser'
  fileType       = 'exe'
  softwareName   = 'TV-Browser*'

  checksum       = ''
  checksumType   = ''
  url            = 'https://sourceforge.net/projects/tvbrowser/files/TV-Browser%20Releases%20%28Java%208%20and%20higher%29/4/tvbrowser_4_win32.exe/download'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
