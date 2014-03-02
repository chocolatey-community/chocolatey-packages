$packageName = 'nomacs'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/nomacs/files/nomacs-1.6.4/nomacs-setup.1.6.4-x86.exe/download'
$url64bit = 'http://sourceforge.net/projects/nomacs/files/nomacs-1.6.4/nomacs-setup-1.6.4-x64.exe/download'

# If Windows 2000/XP, download matching version
$WinVersion = [System.Environment]::OSVersion.Version.Major
if ($WinVersion -eq 5) {
Install-ChocolateyPackage $packageName $fileType $silentArgs 'http://sourceforge.net/projects/nomacs/files/nomacs-1.6.4/nomacs-setup-1.6.4-WinXP-x86.exe/download'
}


# If Windows Vista/7/8 or later, download matching version
$WinVersion = [System.Environment]::OSVersion.Version.Major
if ($WinVersion -ge 6) {
Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
}