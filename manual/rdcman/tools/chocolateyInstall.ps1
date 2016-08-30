$packageName = 'rdcman'
$installerType = 'MSI'
$32BitUrl = 'https://download.microsoft.com/download/A/F/0/AF0071F3-B198-4A35-AA90-C68D103BDCCF/rdcman.msi'
$checksum = '6E29F25C5E7F5EC587D07642A344B05429472A75B4F73177CD6AAC63BE61A455'
$checksumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0,3010)

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -checksum $checksum -checksumType $checksumType -validExitCodes $validExitCodes