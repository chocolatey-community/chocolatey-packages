$packageName = 'allmyapps'
$version = '2.0.0.30'
$exeToVersioning = "$Env:userprofile\AppData\Roaming\Allmyapps\Allmyapps.exe"
$fileType = 'exe'

#AutoHotKey 
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}Install.exe"

$url = 'http://download.allmyapps.com/Allmyapps.exe'
$silentArgs = '/S'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$mantainer = 'tonigellida'

# Variables for the AutoHotkey-script
$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile = "$scriptPath\$packageName.ahk"

try {

 	if (Test-Path $exeToVersioning) {
		$installedVersion = (Get-Command $exeToVersioning).FileVersionInfo.FileVersion
	}

	if ($installedVersion -gt $version) {
		Write-Host "Your $packageName $installedVersion is higher than the $version proporcionated by chocolatey repo."
		Write-Host "Please wait or contact the mantainer $mantainer to update this package."
		Write-Host "When the package is updated try another time. Thanks."
		
	}elseif ($installedVersion -eq $version) {
		Write-Host "$packageName $version is already installed."
		
	} else {

        # Download and install the program

        if (-not (Test-Path $filePath)) {
            New-Item $filePath -type directory
        }

        Get-ChocolateyWebFile $packageName $fileFullPath $url
        Start-Process 'AutoHotkey' $ahkFile
        Start-Process $fileFullPath $silentArgs
        Wait-Process -Name "allmyappsInstall"
        Remove-Item $fileFullPath
    }

    Write-ChocolateySuccess $packageName

} catch {

    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}

