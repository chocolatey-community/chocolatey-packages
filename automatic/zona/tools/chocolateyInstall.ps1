$packageName = '{{PackageName}}'
$fileType = 'exe'

#AutoHotKey 
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}Install.exe"
$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile = "$scriptPath\zonaInstall.ahk"

$url = '{{DownloadUrl}}'
$silentArgs = '/S'
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	if (-not (Test-Path $filePath)) {
		New-Item $filePath -type directory
	}

	Get-ChocolateyWebFile $packageName $fileFullPath $url
	Start-Process 'AutoHotkey' $ahkFile
	Start-Process $fileFullPath $silentArgs
	Wait-Process -Name "zonaInstall"
	Remove-Item $fileFullPath
    }

	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}

