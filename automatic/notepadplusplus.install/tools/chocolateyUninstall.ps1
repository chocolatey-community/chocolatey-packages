$packageName = 'notepadplusplus.install'
$fileType = 'EXE'
$silentArgs = '/S'
$uninst = Get-UninstallRegistryKey -softwareName 'Notepad++*'

Uninstall-ChocolateyPackage -packageName $packageName -fileType $fileType -silentArgs $silentArgs -file $uninst.UninstallString
