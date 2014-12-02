$packageName = 'palemoon'
$installerType = 'exe'
$url = 'http://relmirror.palemoon.org/release/palemoon-25.1.0.win32.installer.exe'
$url64 = 'http://relmirror.palemoon.org/release/palemoon-25.1.0.win64.installer.exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes
