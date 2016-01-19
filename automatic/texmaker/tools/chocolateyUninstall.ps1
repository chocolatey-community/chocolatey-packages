$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$validExitCodes = @(0)

$unfile = "${Env:ProgramFiles}\Texmaker\uninstall.exe"
$unfilex86 = "${Env:ProgramFiles(x86)}\Texmaker\uninstall.exe"

if (Test-Path "$unfile") {$file = "$unfile"}
if (Test-Path "$unfilex86") {$file = "$unfilex86"}

if ((Test-Path "$unfile") -or (Test-Path "$unfilex86")) {
  Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
}
