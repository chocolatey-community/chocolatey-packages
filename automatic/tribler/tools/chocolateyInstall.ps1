$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = '/silent /passive'
$validExitCodes	= @(0)
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3 = Join-Path $pwd 'tribler.au3'



# Original installer for silent version
# Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes



# Not silent installer, autoit

$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "$packageName"
	if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
$tempFile = Join-Path $tempDir "$packageName.installer.exe"

Get-ChocolateyWebFile "$packageName" "$tempFile" "$url"

Write-Host "Running AutoIt3 using `'$au3`'"
Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'
