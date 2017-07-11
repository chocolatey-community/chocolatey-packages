$packageName	= 'PandaFreeAntivirus'
$url			= '{{DownloadUrl}}'
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3			= Join-Path $pwd 'PandaFreeAntivirus.au3'


try {
	$chocTempDir	= Join-Path $env:TEMP "chocolatey"
	$tempDir		= Join-Path $chocTempDir "$packageName"
		if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
	$tempFile		= Join-Path $tempDir "$packageName.installer.exe"

	Get-ChocolateyWebFile "$packageName" "$tempFile" "$url"
	
	Write-Host "Running AutoIt3 using `'$au3`'"
	Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'

	Write-ChocolateySuccess "$packageName"
} catch {
	Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
	throw
}
