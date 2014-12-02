$packageName = 'flashplayeractivex'
$version = '15.0.0.239'
$installArgs = '/quiet /norestart REMOVE_PREVIOUS=YES'
$url = 'http://download.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_15_active_x.msi'

$majorVersion = ([version] $version).Major

$alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -eq "Adobe Flash Player $majorVersion ActiveX" -and
  $_.Version -eq $version
}

try {

  $allRight = $true


  if ([System.Environment]::OSVersion.Version -ge '6.2') {
    $allRight = $false
    Write-ChocolateyFailure $packageName $('Your Windows version is not ' +
      'suitable for this package. This package is only for Windows XP to Windows 7')
  }

  if (Get-Process iexplore -ErrorAction SilentlyContinue) {
    $allRight = $false
    Write-ChocolateyFailure $packageName 'Internet Explorer is running. ' +
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

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
