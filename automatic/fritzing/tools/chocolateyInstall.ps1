$packageName = '{{PackageName}}'
$url_86 = 'http://fritzing.org/download/0.9.0b/windows/fritzing.0.9.0b.32.pc.zip'
$url_64 = 'http://fritzing.org/download/0.9.0b/windows-64bit/fritzing.0.9.0b.64.pc.zip'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
#$executable = "Fritzing.exe"
$targetFilePath = "$unzipLocation\$executable"
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

try {

	if ($is64bit) {
	    Install-ChocolateyZipPackage $packageName $url_64 $unzipLocation
		$executable = "fritzing.0.9.0b.64.pc\Fritzing.exe"
	} else {
		Install-ChocolateyZipPackage $packageName $url_86 $unzipLocation
		$executable = "fritzing.0.9.0b.32.pc\Fritzing.exe"
	}

	Install-ChocolateyDesktopLink $targetFilePath

	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}

