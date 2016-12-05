$packageName = '{{PackageName}}'
$uninstallRegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\5f7eb300e2ea4ebf"
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = ''

# AutoIt
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$installerFile = Join-Path $scriptDir 'githubforwindows.au3'
$tempDir = "$env:TEMP\chocolatey\$packageName"

$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	if (Test-Path $uninstallRegistryPath) {
		Write-Host "You have $packageName installed yet"
		Write-Host "Update it in-app if proceeds"

	} else {

        # Download and install the program

		# AutoIt

	    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
	    $installerFile = Join-Path $scriptDir 'githubforwindows.au3'

	    $tempDir = "$env:TEMP\chocolatey\$packageName"
	    if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
	    $file = Join-Path $tempDir "githubsetup.exe"
	    Get-ChocolateyWebFile "$packageName" "$file" "$url"
	  
	    write-host "Installing `'$file`' with AutoIt3 using `'$installerFile`'"
	    $installArgs = "/c autoit3 `"$installerFile`" `"$file`""
	    Start-ChocolateyProcessAsAdmin "$installArgs" 'cmd.exe'
	    sleep(15)
		}
	
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}