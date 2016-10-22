$name		= 'HostsMan'
$zipName	= "$name.zip"
$installer	= "HostsMan_Setup.exe"
$silentArgs	= "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
$url		= '{{DownloadUrl}}'
$pwd		= "$(split-path -parent $MyInvocation.MyCommand.Definition)"



$tempDir = Join-Path $env:TEMP $name
	if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$filePath = Join-Path $tempDir $zipName

# Download zip
Get-ChocolateyWebFile "$name" "$filePath" "$url"

# Extract zip
Get-ChocolateyUnzip "$filePath" "$tempDir"

$exeName = Join-Path $tempDir "$installer"

# Execute installer
Install-ChocolateyPackage "$name" "EXE" "$silentArgs" "$exeName"
