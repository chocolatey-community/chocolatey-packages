$packageName = 'vcredist2015'
$installerType = 'EXE'
$32BitUrl = 'http://download.microsoft.com/download/0/4/1/041224F6-A7DC-486B-BD66-BCAAF74B6919/vc_redist.x86.exe'
$64BitUrl = 'http://download.microsoft.com/download/0/4/1/041224F6-A7DC-486B-BD66-BCAAF74B6919/vc_redist.x64.exe'
$silentArgs = '/install /quiet /norestart'
Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl $64BitUrl
