$packageName	= 'PaleMoon'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$url64			= '{{DownloadUrlx64}}'
$silentArgs		= '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes	= @(0)
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3			= Join-Path $pwd 'palemoon.au3'


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes


#try {
#	$chocTempDir	= Join-Path $env:TEMP "chocolatey"
#	$tempDir		= Join-Path $chocTempDir "$packageName"
#		if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
#
#	if (Get-ProcessorBits(64)) {$url = $url64}
#
#	$fileName		= $filename = $url.Substring($url.LastIndexOf("/") + 1)
#	$tempFile		= Join-Path $tempDir "$fileName"
#
#	Get-ChocolateyWebFile "$packageName" "$tempFile" "$url"
#	
#	Write-Host "Running AutoIt3 using `'$au3`'"
#	Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'
#
#	Write-ChocolateySuccess "$packageName"
#} catch {
#	Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
#	throw
#}
