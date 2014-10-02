$packageName = 'ext2fsd'
$fileType = "exe"
$silentArgs = "/VERYSILENT /NORESTART"
$unpath = "${Env:ProgramFiles}\Ext2Fsd\unins000.exe"
$unpathx86 = "${Env:ProgramFiles(x86)}\Ext2Fsd\unins000.exe"
$validExitCodes = @(0,2)

if (Test-Path $unpath) {$file = "$unpath"}
if (Test-Path $unpathx86) {$file = "$unpathx86"}

Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file  -validExitCodes $validExitCodes
Write-Host The system must be rebooted for the changes to be completed.
