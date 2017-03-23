$packageName = 'wixtoolset'
$installerType = 'EXE'
$32BitUrl = 'http://wixtoolset.org/downloads/v3.10.3.3007/wix310.exe'
$silentArgs = '/q'
$validExitCodes = @(0)
$checksum      = '3C125E3551C035F69ED24ACD8FB4EF7B74C1311ECACF1F8FC1EB7E0DD47D9C75'
$checksumType  = 'sha256'

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType
