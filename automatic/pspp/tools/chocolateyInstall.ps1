$packageName = '{{PackageName}}'
$installerType = 'EXE'

$url      = 'http://sourceforge.net/projects/pspp4windows/files/{{DateStamp}}/pspp-{{VersionSec}}%2B{{DateStampSec}}-snapshot-32bits-setup.exe/download'
$url64      = 'http://sourceforge.net/projects/pspp4windows/files/{{DateStamp}}/pspp-{{VersionSec}}%2B{{DateStampSec}}-snapshot-64bits-setup.exe/download'

$silentArgs   = '/S'
$validExitCodes = @(0)
 
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes
