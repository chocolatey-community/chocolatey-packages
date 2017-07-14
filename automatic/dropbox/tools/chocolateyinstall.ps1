$ErrorActionPreference  = 'Stop'

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2030.4.22%20Offline%20Installer.exe'
    checksum        = '4f9c2780691be1fc5fbd70678e55197aa3907c0c810da103148ff5d34f5b7f5c'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

$regex = '(-[a-z]+)'; $re_non = '';
$installedVersion = ( Get-UninstallRegistryKey -SoftwareName "Dropbox" ).DisplayVersion
$packageVersion = @{$true=(($Env:ChocolateyPackageVersion) -replace($regex,$re_non));$false=($Env:ChocolateyPackageVersion)}[ $Env:ChocolateyPackageVersion -match $regex ]

  if ($installedVersion -ge $packageVersion) {
    Write-Host "Dropbox $installedVersion is already installed."
  } else {
	if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {
		Stop-Process -processname Dropbox
	}
	Install-ChocolateyPackage @packageArgs
  }
