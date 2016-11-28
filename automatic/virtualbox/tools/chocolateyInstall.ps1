#https://www.virtualbox.org/manual/ch02.html#idm819
#ALLUSERS=2

$cert = ls cert: -Recurse | ? { $_.Thumbprint -eq 'a88fd9bdaa06bc0f3c491ba51e231be35f8d1ad5' }
if (!$cert) {
    $toolsPath = Split-Path $MyInvocation.MyCommand.Definition
    Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$toolsPath\oracle.cer'"
}

$pp = Get-PackageParameters
$silentArgs = @('-s -l -msiparams REBOOT=ReallySuppress')
$silentArgs += if (!$pp.CurrentUser) { 'ALLUSERS=1' } else { 'ALLUSERS=2'; Write-Host 'Param: Installing for current user' }
$silentArgs += if ($pp.NoDesktopShortcut) { 'VBOX_INSTALLDESKTOPSHORTCUT=0';     Write-Host 'Param: No desktop shortcut' }
$silentArgs += if ($pp.NoQuickLaunch)     { 'VBOX_INSTALLQUICKLAUNCHSHORTCUT=0'; Write-Host 'Param: No quick launch shortcut' }
$silentArgs += if ($pp.NoRegister)        { 'VBOX_REGISTERFILEEXTENSIONS=0';     Write-Host 'Param: No registration for virtualbox file extensions' }

$packageArgs = @{
  packageName            = 'virtualbox'
  fileType               = 'EXE'
  url                    = 'http://download.virtualbox.org/virtualbox/5.1.10/VirtualBox-5.1.10-112026-Win.exe'
  url64bit               = 'http://download.virtualbox.org/virtualbox/5.1.10/VirtualBox-5.1.10-112026-Win.exe'
  checksum               = '24193297a1d6ed14450c9569955768421ec433e5f93a02a5aa9a8c9214a080ed'
  checksum64             = '24193297a1d6ed14450c9569955768421ec433e5f93a02a5aa9a8c9214a080ed'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = $silentArgs
  validExitCodes         = @(0)
  softwareName           = 'Oracle VM VirtualBox *'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  {
    Write-Warning "Can't find $packageName install location"
    return
}

Write-Host "$packageName installed to '$installLocation'"

if (!$pp.NoPath) { Install-ChocolateyPath $installLocation }

Register-Application "$installLocation\$packageName.exe" vbox
Write-Host "$packageName registered as vbox"

Write-Host "Installing latest extension pack"
$installer_path = "$(Get-PackageCacheLocation)/VirtualBox*.exe"
& $installer_path --path (Split-Path $installer_path) --extract --silent
$ep = gi "$installer_path\*.vbox-extpack$"
if (!$ep) { Write-Warning "Can't find latest extension pack, it will not be installed"; return }

Set-Alias vboxmanage $installLocation\VBoxManage.exe
vboxmanage extpack install --replace $ep
