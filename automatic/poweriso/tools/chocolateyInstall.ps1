$ErrorActionPreference = 'Stop'

$download_content = Get-WebContent 'http://www.poweriso.com/download.htm'

$reMatches = [regex]::Matches($download_content, '\<a class="download_link" href="([^"]+)"')

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = $reMatches[0].Groups[1]
  url64bit               = $reMatches[1].Groups[1]
  checksum               = '925fb61d45e7239e8848d0bb70847eef0ff3987d72efa98d61d13cb304bfc8d0'
  checksum64             = '40d83449781f8a6c498eed86f6ce2409b3d58a63fb5ccad3dc76157600ee0a7f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
