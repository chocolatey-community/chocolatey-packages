$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'tv-browser'
  fileType       = 'exe'
  softwareName   = 'TV-Browser*'

  checksum       = '950dc6e712ccfebe3ff742ff2d1a4cf3f1d93c746432c055a0123bfa294197f8'
  checksumType   = 'sha256'
  url            = 'https://sourceforge.net/projects/tvbrowser/files/TV-Browser%20Releases%20%28Java%208%20and%20higher%29/4/tvbrowser_4_win32.exe/download'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
