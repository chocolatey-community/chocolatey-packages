$ErrorActionPreference = 'Stop'

$download_content = Get-WebContent 'http://www.poweriso.com/download.htm'

$reMatches = [regex]::Matches($download_content, '\<a class="download_link" href="([^"]+)"')

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = $reMatches[0].Groups[1]
  url64bit               = $reMatches[1].Groups[1]
  checksum               = '3a18891f5cc5f2fcf46fc1b4eda3c99ebaee4c06d4b8e6409507096d45985c76'
  checksum64             = 'b8c6a05c6322d1884f0c5347dfde9d1f95ab58218a20b9c884d3a5e78b315d8d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
