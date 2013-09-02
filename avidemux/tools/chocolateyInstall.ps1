$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/avidemux/files/avidemux/{{PackageVersion}}/avidemux_{{PackageVersion}}_win32.exe/download'
$url64bit = 'http://sourceforge.net/projects/avidemux/files/avidemux/{{PackageVersion}}/avidemux_{{PackageVersion}}_win64.exe/download'
$validExitCodes = @(0,1223)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit -validExitCodes $validExitCodes