# This file should be identical for all python* packages

$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$version = '{{PackageVersion}}'
$fileType = 'msi'
$partialInstallArgs = '/qn /norestart ALLUSERS=1 TARGETDIR='



  $binRoot = Get-BinRoot
  $installPath = Join-Path $binRoot $packageName

  # The name of the installed Python version from Win32_Product
  $win32ProductName = $('^Python' + ' ' + [regex]::escape($version) + '$')

  # The Get-ProcessorBits is a misnomer. It returns the OS bitness, not the CPU bitness
  $osBitness = Get-ProcessorBits

  # If the OS is 64-bit and the package is not Python 32-bit specific,
  # it detects only an installed 64-bit version. This is incompatible with
  # the usage of the '-x86' parameter of Chocolatey, but I know no other
  # method to do this. Therefore I also created 32-bit specific Python packages
  # ({{PackageName}}-x86_32 in this case).
  if (($osBitness -eq 64) -and ($packageName -notmatch 32)) {
    $win32ProductName = $('^Python' + ' ' + [regex]::escape($version) + ' ' + '\(64-bit\)$')
  }


  # Check if the same version and bitness of Python is already installed
  $sameVersionAlreadyInstalled = Get-WmiObject -Class Win32_Product |
    Where-Object {$_.Name -match $win32ProductName}

  # Construct the old installation path, which is mostly C:\PythonXX,
  # where XX stands for the major and minor version digits.
  $versionMajorMinor = $version -replace '^(\d+)\.(\d+).*', '$1$2'
  $oldInstallPath = Join-Path $env:SystemDrive "Python$versionMajorMinor"

  if (Test-Path $oldInstallPath) {
    $installPath = $oldInstallPath
    Write-Output @"
Warning: Old installation path “$oldInstallPath” detected.
This package will continue to install $packageName there unless you uninstall
$packageName from there and remove the “$oldInstallPath” folder. If you decide
to do that, reinstall this package with the -force parameter and it will
install to the Chocolatey bin root.

"@
  }

  $installArgs = $($partialInstallArgs + '"' + $installPath + '"')

  # Check if the same version of Python is already installed.
  # This prevents 1603 errors during the installation and an
  # unnecessary download of the Python installer.
  if ($sameVersionAlreadyInstalled) {
    Write-Output @"
$packageName v$version is already installed. Skipping unnecessary download
and installation. If you have installed $packageName in “$oldInstallPath”
and you want to use the Chocolatey bin root as installation path instead,
uninstall $packageName from the control panel, remove the “$oldInstallPath”
folder and reinstall this package with the -force parameter.

"@
  } else {
    # Otherwise install Python and and add the installation folder to the PATH.

    # If the package is only intended for the 32-bit version, only pass
    # the 32-bit version to the install package function.
    if ($packageName -match 32) {
      Install-ChocolateyPackage $packageName $fileType $installArgs $url
    } else {
      Install-ChocolateyPackage $packageName $fileType $installArgs $url $url64
    }


    Install-ChocolateyPath $installPath 'Machine'
    $env:Path = "$($env:Path);$installPath;$installPath\Scripts"
  }


