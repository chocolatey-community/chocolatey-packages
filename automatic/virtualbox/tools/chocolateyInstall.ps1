#https://www.virtualbox.org/manual/ch02.html#idm819

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$cert = Get-ChildItem Cert:\CurrentUser\TrustedPublisher -Recurse | Where-Object { $_.Thumbprint -eq 'a88fd9bdaa06bc0f3c491ba51e231be35f8d1ad5' }
if (!$cert) {
    $toolsPath = Split-Path $MyInvocation.MyCommand.Definition
    Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$toolsPath\oracle.cer'"
}

$pp = Get-PackageParameters
$silentArgs = @('-s -l -msiparams REBOOT=ReallySuppress')
$silentArgs += if (!$pp.CurrentUser)      { 'ALLUSERS=1' } else { 'ALLUSERS=2';  Write-Host 'Param: Installing for current user' }
$silentArgs += if ($pp.NoDesktopShortcut) { 'VBOX_INSTALLDESKTOPSHORTCUT=0';     Write-Host 'Param: No desktop shortcut' }
$silentArgs += if ($pp.NoQuickLaunch)     { 'VBOX_INSTALLQUICKLAUNCHSHORTCUT=0'; Write-Host 'Param: No quick launch shortcut' }
$silentArgs += if ($pp.NoRegister)        { 'VBOX_REGISTERFILEEXTENSIONS=0';     Write-Host 'Param: No registration for virtualbox file extensions' }

$packageArgs = @{
  packageName            = 'virtualbox'
  fileType               = 'EXE'
  url                    = 'https://download.virtualbox.org/virtualbox/7.2.6/VirtualBox-7.2.6-172322-Win.exe'
  url64bit               = 'https://download.virtualbox.org/virtualbox/7.2.6/VirtualBox-7.2.6-172322-Win.exe'
  checksum               = '5194a1695d1b4c07d129e2b1e2088adc3dd2f1f0f73699004375d6dfdfa60fd7'
  checksum64             = '5194a1695d1b4c07d129e2b1e2088adc3dd2f1f0f73699004375d6dfdfa60fd7'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = $silentArgs
  validExitCodes         = @(0, 3010)
  softwareName           = 'Oracle VM VirtualBox *'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-VirtualBoxIntallLocation
if (!$installLocation)  { Write-Warning "Can't find $packageName install location, can't install extension pack"; return }

if ($pp.ExtensionPack) {
    Write-Host "Installing extension pack"
    Write-Warning "*** THIS IS A COMMERCIAL EXTENSION AND CAN INCURE SIGNIFICANT FINANCIAL COSTS ***"

    $url_ep       = 'https://download.virtualbox.org/virtualbox/7.2.6/Oracle_VirtualBox_Extension_Pack-7.2.6.vbox-extpack'
    $checksum_ep  = 'd46449366b23417a626439785f23f7eaf06bfbfd2cb030713e1abfa5b03d4205'
    $file_path_ep = (Get-PackageCacheLocation) + '\' + ($url_ep -split '/' | Select-Object -Last 1)
    Get-ChocolateyWebFile `
        -PackageName    'virtualbox-extensionpack' `
        -FileFullPath   $file_path_ep `
        -Url            $url_ep `
        -Url64bit       $url_ep `
        -Checksum       $checksum_ep `
        -Checksum64     $checksum_ep `
        -ChecksumType   'sha256' `
        -ChecksumType64 'sha256'
    if (!(Test-Path $file_path_ep)) { Write-Warning "Can't download latest extension pack" }
    else {
        Set-Alias vboxmanage $installLocation\VBoxManage.exe
        "y" | vboxmanage extpack install --replace $file_path_ep 2>&1
        if ($LastExitCode -ne 0) { Write-Warning "Extension pack installation failed with exit code $LastExitCode" }
    }
}

if (!$pp.NoPath) { Write-Host "Adding to PATH if needed"; Install-ChocolateyPath $installLocation }

Write-Host "$packageName installed to '$installLocation'"
Register-Application "$installLocation\$packageName.exe" vbox
Write-Host "$packageName registered as vbox"
