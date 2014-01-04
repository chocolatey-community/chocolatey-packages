$packageName = '{{PackageName}}'
$installerType = 'MSI'
$32BitUrl  = 'http://download.calibre-ebook.com/{{PackageVersion}}/calibre-{{PackageVersion}}.msi'
$64BitUrl  = 'http://download.calibre-ebook.com/{{PackageVersion}}/calibre-64bit-{{PackageVersion}}.msi'
$silentArgs = '/quiet'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes