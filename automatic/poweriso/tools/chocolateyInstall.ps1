$ErrorActionPreference = 'Stop'

$download_content = Get-WebContent 'https://www.poweriso.com/download.htm'

$reMatches = [regex]::Matches($download_content, '\<a class="download_link" href="([^"]+)"')

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = $reMatches[0].Groups[1]
  url64bit               = $reMatches[1].Groups[1]
  checksum               = '037acfb14c28a3dacdf8ffd978e2efdfc9aaedaff72b9f25bea7b4442b4dc392'
  checksum64             = 'b979b79a8c40e697ee410a4844b1207ac71cba97d8991e0b4cd07bb2ae7bece8'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
