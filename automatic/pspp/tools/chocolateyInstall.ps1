$packageName = '{{PackageName}}'
$installerType = 'EXE'

$url      = 'http://sourceforge.net/projects/pspp4windows/files/{{DateLine}}/pspp-{{VersionSec}}-{{DateLineSec}}-32bits-Setup.exe/download'
$url64      = 'http://sourceforge.net/projects/pspp4windows/files/{{DateLine}}/pspp-{{VersionSec}}-{{DateLineSec}}-64bits-Setup.exe/download'

$silentArgs   = '/S'
$validExitCodes = @(0)
 
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes
