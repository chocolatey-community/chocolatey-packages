$packageName = 'flashplayeractivex'
$version = '24.0.0.194'
$majorVersion = '24'
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
  url           = 'https://fpdownload.macromedia.com/pub/flashplayer/pdc/24.0.0.194/install_flash_player_24_plugin.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Adobe Flash Player ActiveX'
  checksum      = '81d5c96efe58e6ddaaa296da282688eb656ade966fa97671c87b1a89427f1583'
  checksumType  = 'sha256'
}
  Install-ChocolateyPackage @packageArgs
}
