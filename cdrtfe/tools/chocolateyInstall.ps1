$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /COMPONENTS=`"prog,prog\langsupport,tools,tools\cdrt,tools\m2cdm,tools\xcd,tools\audio,tools\vcd`"'
#$url = 'http://sourceforge.net/projects/cdrtfe/files/cdrtfe/cdrtfe%201.5.0/cdrtfe-1.5.exe'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url