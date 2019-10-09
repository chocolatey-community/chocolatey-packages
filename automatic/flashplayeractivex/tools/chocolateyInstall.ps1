$packageName = 'flashplayeractivex'
$version = '32.0.0.270'
$majorVersion = '32'
$registry = ( Get-UninstallRegistryKey -SoftwareName "Adobe Flash Player $majorVersion ActiveX" ).DisplayVersion
$checking = ( $registry -eq $version )
$alreadyInstalled = @{$true = "Adobe Flash Player ActiveX for IE $version is already installed."; $false = "Adobe Flash Player ActiveX for IE $version is not already installed."}[ $checking ]

$allRight = $true

if ([System.Environment]::OSVersion.Version -ge '6.2') {
  $allRight = $false
  Write-Output $packageName $('Your Windows version is not ' +
    'suitable for this package. This package is only for Windows XP to Windows 7')
}

if (Get-Process iexplore -ErrorAction SilentlyContinue) {
  $allRight = $false
  Write-Output $packageName 'Internet Explorer is running. ' +
    'The installation will fail an 1603 error. ' +
    'Close Internet Explorer and reinstall this package.'
}

if ( $checking ) {
  $allRight = $false
  Write-Output $alreadyInstalled
}

if ($allRight) {
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/32.0.0.270/install_flash_player_32_active_x.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Adobe Flash Player ActiveX'
  checksum      = 'a9d47df2fe7e14dd523edc2546f87c1aadf16fe809824e27550d101a378b3c4e'
  checksumType  = 'sha256'
}
  Install-ChocolateyPackage @packageArgs
}
