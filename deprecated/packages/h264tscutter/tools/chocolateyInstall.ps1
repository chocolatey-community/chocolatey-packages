$packageName = '{{PackageName}}'
$url = 'http://www.videohelp.com/download/h264ts_cutter_v111.zip'
$referer = "http://www.videohelp.com/tools/H264TS-Cutter"
$fileFullPath = "$env:TEMP\h264ts_cutter_v111.zip"
$destination = "$env:SystemDrive\$env:chocolatey_bin_root\h264tscutter"
$targetFilePath = "$env:SystemDrive\$env:chocolatey_bin_root\h264tscutter\H264TS_Cutter.exe"

wget -P "$env:TEMP" --referer=$referer $url

Get-ChocolateyUnzip $fileFullPath $destination
Remove-Item $fileFullPath
Install-ChocolateyDesktopLink $targetFilePath

$desktop = [Environment]::GetFolderPath("Desktop")
Rename-Item "$desktop\H264TS_Cutter.exe.lnk" "H.264 TS Cutter.lnk"
$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
Copy-Item "$desktop\H.264 TS Cutter.lnk" "$startMenu\Programs\"
