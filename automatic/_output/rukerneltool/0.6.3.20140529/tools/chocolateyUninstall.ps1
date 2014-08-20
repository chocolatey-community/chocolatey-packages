if (Test-Path "$env:HOMEDRIVE\ruKernelTool") {
    Remove-Item "$env:HOMEDRIVE\ruKernelTool" -Recurse -Force
}

$desktop = "$([Environment]::GetFolderPath("Desktop"))"
$startMenu = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))\Programs"

if (Test-Path "$desktop\ruKernelTool.lnk") {
    Remove-Item "$desktop\ruKernelTool.lnk"
}

if (Test-Path "$startMenu\ruKernelTool.lnk") {
    Remove-Item "$startMenu\ruKernelTool.lnk"
}