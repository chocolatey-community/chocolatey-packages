$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$unpath = "$Env:ProgramFiles\CCleaner\uninst.exe"
$validExitCodes = @(0)

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
