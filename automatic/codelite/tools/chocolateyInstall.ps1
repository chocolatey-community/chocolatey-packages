$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'

$url = 'http://sourceforge.net/projects/codelite/files/Releases/codelite-{{PackageVersion}}/codelite-x86-{{PackageVersion}}.exe/download'
$url64 = 'http://sourceforge.net/projects/codelite/files/Releases/codelite-{{PackageVersion}}/codelite-amd64-{{PackageVersion}}.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
