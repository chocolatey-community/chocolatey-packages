try {

	$packageName = '{{PackageName}}'

	$exeFileLink = "H.264 TS Cutter.lnk"
	$desktop = [Environment]::GetFolderPath("Desktop")
	if (Test-Path "$desktop\$exeFileLink") {Remove-Item "$desktop\$exeFileLink"}

	$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
	if (Test-Path "$startMenu\Programs\$exeFileLink") {Remove-Item "$startMenu\Programs\$exeFileLink"}

	$destination = "$env:SystemDrive\$env:chocolatey_bin_root\h264tscutter"
	if (Test-Path "$destination") {Remove-Item "$destination" -Recurse}

	Write-ChocolateySuccess $packageName
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
