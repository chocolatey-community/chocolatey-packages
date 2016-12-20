$packageName = 'tsremux'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$validExitCodes = @(0)

$unfile = "${Env:ProgramFiles}\TsRemux\unins000.exe"
$unfilex86 = "${Env:ProgramFiles(x86)}\TsRemux\unins000.exe"

if (Test-Path "$unfile") {$file = "$unfile"}
if (Test-Path "$unfilex86") {$file = "$unfilex86"}

if ((Test-Path "$unfile") -or (Test-Path "$unfilex86")) {
  Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
}
