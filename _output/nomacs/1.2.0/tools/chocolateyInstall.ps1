$packageName = 'nomacs'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://heanet.dl.sourceforge.net/project/nomacs/nomacs-1.2.0/nomacs-setup-1.2.0-x86.exe'
$url64bit = 'http://freefr.dl.sourceforge.net/project/nomacs/nomacs-1.2.0/nomacs-setup-1.2.0-x64.exe'

# If Windows 2000/XP, download matching version
$WinVersion = [System.Environment]::OSVersion.Version.Major
if ($WinVersion -eq 5) {
Install-ChocolateyPackage $packageName $fileType $silentArgs 'http://sourceforge.net/projects/nomacs/files/nomacs-1.2.0/nomacs-setup-1.2.0-WinXP-x86.exe/download'
}


# If Windows Vista/7/8 or later, download matching version
$WinVersion = [System.Environment]::OSVersion.Version.Major
if ($WinVersion -ge 6) {
Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
}