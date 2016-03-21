$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$installerType = 'EXE'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = "http://sourceforge.net/projects/bulk-crap-uninstaller/files/BCUninstaller_${version}_setup.exe/download"

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
