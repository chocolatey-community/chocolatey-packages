$packageName = '{{PackageName}}'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlArray = {{DownloadUrlx64}}
$url = $urlArray[0]
$url64 = $urlArray[1]
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
