$packageName = 'rukerneltool'
$downloadFile = "ruKernelTool.zip"
$url = "http://rukerneltool.rainerullrich.de/download2/ruKernelTool.zip"

cd "$env:TEMP"

if (Test-Path "$downloadFile") {Remove-Item "$downloadFile"}

wget --user="ruKernelTool2" --password="Bommelchen_2010" $url

`7za x -o"$env:HOMEDRIVE" -y "$downloadFile"
Remove-Item "$downloadFile"

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

$desktop = "$([Environment]::GetFolderPath("Desktop"))"
$startMenu = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))\Programs"

if ($is64bit) {
    Install-ChocolateyDesktopLink "$env:HOMEDRIVE\ruKernelTool\ruKernelTool_x64.exe"
    Rename-Item -Path "$desktop\ruKernelTool_x64.exe.lnk" -NewName "ruKernelTool.lnk"
} else {
    Install-ChocolateyDesktopLink "$env:HOMEDRIVE\ruKernelTool\ruKernelTool.exe"
    Rename-Item -Path "$desktop\ruKernelTool.exe.lnk" -NewName "ruKernelTool.lnk"
}

Copy-Item "$desktop\ruKernelTool.lnk" -Destination "$startMenu"