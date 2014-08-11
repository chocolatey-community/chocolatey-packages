$packageName = 'feeddemon'
$installerType = 'EXE'
$32BitUrl  = 'http://bradsoft.com/download/FeedDemonInstall45.exe'
$64BitUrl  = $32BitUrl
$silentArgs = '/verysilent'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes