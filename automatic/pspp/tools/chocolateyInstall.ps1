#$url      = 'http://sourceforge.net/projects/pspp4windows/files/{{DateStamp}}/pspp-{{VersionSec}}%2B{{DateStampSec}}-snapshot-32bits-setup.exe/download'
#$url64      = 'http://sourceforge.net/projects/pspp4windows/files/{{DateStamp}}/pspp-{{VersionSec}}%2B{{DateStampSec}}-snapshot-64bits-setup.exe/download'

Install-ChocolateyPackage "{{PackageName}}" "EXE" "/S" "{{DownloadUrl}}" "{{DownloadUrlx64}}" -validExitCodes @(0)
