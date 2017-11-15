$packageName = 'cmake.install'
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'http://cmake.org/files/v3.9/cmake-3.9.4-win64-x64.msi'
$checksum = '1c5c6f32e5ce4b2f202f9c50fd7fc60c9b7bd29ddf375a75bc63d58066090e2a'
$checksumType = 'sha256'
$validExitCodes = @(0,3010)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"