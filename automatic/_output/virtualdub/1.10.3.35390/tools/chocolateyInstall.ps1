$packageName = 'virtualdub'
$url = 'http://netcologne.dl.sourceforge.net/project/virtualdub/virtualdub-experimental/1.10.3.35390/VirtualDub-1.10.3.zip'
$url64 = 'http://kent.dl.sourceforge.net/project/virtualdub/virtualdub-experimental/1.10.3.35390/VirtualDub-1.10.3-AMD64.zip'
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