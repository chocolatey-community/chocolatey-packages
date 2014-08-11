$packageName = 'cdburnerxp'
$installerType = 'MSI'
$32BitUrl  = 'http://download.cdburnerxp.se/msi/cdbxp_setup_4.5.4.5000.msi'
$64BitUrl  = 'http://download.cdburnerxp.se/msi/cdbxp_setup_x64_4.5.4.5000.msi'
$silentArgs = '/quiet'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes