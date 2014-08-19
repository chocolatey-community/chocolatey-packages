$packageName = '{{PackageName}}'
$fileType = "exe"
$silentArgs = "/S"
$unpath = "${Env:ProgramFiles}\Dokan\DokanLibrary\DokanUninstall.exe"
$unpathx86 = "${Env:ProgramFiles(x86)}\Dokan\DokanLibrary\DokanUninstall.exe"
$validExitCodes = @(0)

if (Test-Path $unpath) {$file = "$unpath"}
if (Test-Path $unpathx86) {$file = "$unpathx86"}

Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file  -validExitCodes $validExitCodes
Write-Host The system must be rebooted for the changes to be completed.
