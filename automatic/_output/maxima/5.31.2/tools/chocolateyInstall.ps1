$packageName = 'maxima'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'

# 5.31.2 gets “misused” as real version here
$realVersion = '5.31.2'

$shortVersion = $realVersion -replace '\-.+', ''

$url = "http://sourceforge.net/projects/maxima/files/Maxima-Windows/${shortVersion}-Windows/maxima-${realVersion}.exe/download"
Install-ChocolateyPackage $packageName $fileType $silentArgs $url