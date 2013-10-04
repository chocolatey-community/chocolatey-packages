$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'

# {{DownloadUrlx64}} gets “misused” as real version here
$realVersion = '{{DownloadUrlx64}}'

$shortVersion = $realVersion -replace '\-.+', ''

$url = "http://sourceforge.net/projects/maxima/files/Maxima-Windows/${shortVersion}-Windows/maxima-${realVersion}.exe/download"
Install-ChocolateyPackage $packageName $fileType $silentArgs $url