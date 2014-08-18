$packageName = '{{PackageName}}'
$fileType = 'exe'
$installArgs = '/VERYSILENT'
$validExitCodes = @(0)
$regPath32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\cdrtools Frontend_is1'
$regPath64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\cdrtools Frontend_is1'

try {

	if (Test-Path $regPath32) {
		$regPath = $regPath32
	}

	if (Test-Path $regPath64) {
		$regPath = $regPath64
	}

	if ($regPath) {
		$unfile = (Get-ItemProperty -Path $regPath -Name 'UninstallString').UninstallString
		Uninstall-ChocolateyPackage $packageName $fileType $installArgs $unfile -validExitCodes $validExitCodes
	}

	Write-ChocolateySuccess $packageName
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
