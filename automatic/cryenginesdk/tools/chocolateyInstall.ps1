try {
	$packageName = '{{PackageName}}'
    $url = '{{DownloadUrl}}'
	$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
	$processor = Get-WmiObject Win32_Processor
	$is64bit = $processor.AddressWidth -eq 64
	
    Install-ChocolateyZipPackage $packageName $url $unzipLocation
	
	if ($is64bit) {
    $targetFilePath1 = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Bin64\DedicatedServerSDK.exe"
    $targetFilePath2 = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Bin64\Editor.exe"
    $targetFilePath3 = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Bin64\GameSDK.exe"
	} else {
    $targetFilePath1 = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Bin32\DedicatedServerSDK.exe"
    $targetFilePath2 = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Bin32\Editor.exe"
    $targetFilePath3 = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Bin32\GameSDK.exe"
	}
    
    Install-ChocolateyDesktopLink $targetFilePath1
    Install-ChocolateyDesktopLink $targetFilePath2
    Install-ChocolateyDesktopLink $targetFilePath3

    Write-ChocolateySuccess $packageName
}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}