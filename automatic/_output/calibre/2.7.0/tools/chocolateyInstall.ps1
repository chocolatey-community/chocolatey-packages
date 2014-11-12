$packageName = 'calibre'
$installerType = 'MSI'
$32BitUrl  = 'http://download.calibre-ebook.com/2.7.0/calibre-2.7.0.msi'
$64BitUrl  = 'http://download.calibre-ebook.com/2.7.0/calibre-64bit-2.7.0.msi'
$silentArgs = '/quiet'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes