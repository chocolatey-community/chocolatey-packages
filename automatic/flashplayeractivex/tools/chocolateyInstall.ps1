$packageName = 'flashplayeractivex'
$version = '24.0.0.186'
$majorVersion = '24'
$installArgs = '/quiet /norestart REMOVE_PREVIOUS=YES'
$url = 'http://download.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_24_active_x.msi'
$checksum = 'D1D60DF68B172F2CB21E4F8572BBB6727385BF4E5874DF95560947D35956BB9D'
$checksumType = 'sha256'

$alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -eq "Adobe Flash Player $majorVersion ActiveX" -and
  $_.Version -eq $version
}

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

if ($alreadyInstalled) {
  $allRight = $false
  Write-Output "Adobe Flash Player ActiveX for IE $version is already installed."
}

if ($allRight) {
  Install-ChocolateyPackage $packageName 'msi' $installArgs $url
}
