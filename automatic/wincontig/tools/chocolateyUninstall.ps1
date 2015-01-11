$packageName = '{{PackageName}}'
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
#$shortcut_to_remove = " "
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

try {

	if ($is64bit) {
		$shortcut_to_remove = "WinContig64.exe.lnk"
	} else {
		$shortcut_to_remove = "WinContig.exe.lnk"
	}	

	Remove-Item "$desktop\$shortcut_to_remove"
  
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}