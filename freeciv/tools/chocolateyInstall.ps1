$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
# DownloadUrlx64 gets “misused” here as trimmed version variable
$url = 'http://sourceforge.net/projects/freeciv/files/Freeciv {{DownloadUrlx64}}/{{PackageVersion}}/Freeciv-{{PackageVersion}}-win32-gtk2-setup.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url