$packageName = 'virtualdub'
$url = 'http://optimate.dl.sourceforge.net/project/virtualdub/virtualdub-win/1.10.4.35491/VirtualDub-1.10.4.zip'
$url64 = 'http://optimate.dl.sourceforge.net/project/virtualdub/virtualdub-win/1.10.4.35491/VirtualDub-1.10.4-AMD64.zip'
$binRoot = "$env:systemdrive\tools"
$unzipLocation = "$binRoot\VirtualDub"

Install-ChocolateyZipPackage $packageName $url $unzipLocation $url64

$desktop = "$([Environment]::GetFolderPath("Desktop"))"
$startMenu = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))\Programs"

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

if ($is64bit) {
    Install-ChocolateyDesktopLink "$unzipLocation\Veedub64.exe"
    Rename-Item -Path "$desktop\Veedub64.exe.lnk" -NewName "VirtualDub.lnk"
} else {
    Install-ChocolateyDesktopLink "$unzipLocation\VirtualDub.exe"
    Rename-Item -Path "$desktop\VirtualDub.exe.lnk" -NewName "VirtualDub.lnk"
}

Copy-Item "$desktop\VirtualDub.lnk" -Destination "$startMenu"