$packageName = 'flashplayerppapi'
$programName = 'Adobe Flash Player PPAPI'
$fileType = 'EXE'
$silentArgs = '-uninstall pepperplugin'

$key32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
$key64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'
$key = @{64=$key64;32=$key32}[(Get-ProcessorBits)]

$uninstaller = Get-ChildItem $key | %{ Get-ItemProperty $_.PSPath } | ?{ $_.PSChildName -match $programName }

$uninstallString = $uninstaller.uninstallString -replace " -maintain pepperplugin",""

if ($uninstallString) {
    Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $uninstallString
}
