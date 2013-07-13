$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/nomacs/files/nomacs-{{PackageVersion}}/nomacs-setup.{{PackageVersion}}-x86.exe/download'
$url64bit = 'http://sourceforge.net/projects/nomacs/files/nomacs-{{PackageVersion}}/nomacs-setup-{{PackageVersion}}-x64.exe/download'

# If Windows 2000/XP, download matching version
$WinVersion = [System.Environment]::OSVersion.Version.Major
if ($WinVersion -eq 5) {
Install-ChocolateyPackage $packageName $fileType $silentArgs 'http://sourceforge.net/projects/nomacs/files/nomacs-{{PackageVersion}}/nomacs-setup-{{PackageVersion}}-WinXP-x86.exe/download'
}


# If Windows Vista/7/8 or later, download matching version
$WinVersion = [System.Environment]::OSVersion.Version.Major
if ($WinVersion -ge 6) {
Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
}