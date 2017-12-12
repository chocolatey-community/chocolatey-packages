$packageName = 'flashplayeractivex'
$version = '28.0.0.126'
$majorVersion = '28'
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
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/28.0.0.126/install_flash_player_28_active_x.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Adobe Flash Player ActiveX'
  checksum      = '974bde92afb8776cc5fc2af8b35fee85c47520892d40dd61d061fa8de7b9d5dd'
  checksumType  = 'sha256'
}
  Install-ChocolateyPackage @packageArgs
}
