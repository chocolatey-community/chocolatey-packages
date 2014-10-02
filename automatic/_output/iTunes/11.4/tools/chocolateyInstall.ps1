$packageName = 'iTunes'
$version = '11.4'
$url = 'https://secure-appldnld.apple.com/iTunes11/031-06979.20140909.Ppfef/iTunesSetup.exe'
$url64 = 'https://secure-appldnld.apple.com/iTunes11/031-06980.20140909.Ffgt9/iTunes64Setup.exe'
$fileType = 'msi'
$silentArgs = '/quiet /norestart'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}Install.exe"
$validExitCodes = @(0, 3010)

function findMsid {
  param([String]$registryUninstallRoot, [string]$keyContentMatch, [string]$version)

  if (Test-Path $registryUninstallRoot) {
    Get-ChildItem -Force -Path $registryUninstallRoot | foreach {
      $currentKey = (Get-ItemProperty -Path $_.PsPath)
      if ($currentKey -match $keyContentMatch -and $currentKey -match $version) {
        return $currentKey.PsChildName
      }
    }
  }

  return $null
}

try {

  $registryUninstallRoot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
  $alreadyInstalled = findMsid $registryUninstallRoot 'iTunes' $version
  if ($alreadyInstalled) {
    Write-Output "iTunes $version is already installed."
  } else {

    if (-not (Test-Path $filePath)) {
      New-Item -ItemType directory -Path $filePath
    }

    Get-ChocolateyWebFile $packageName $fileFullPath $url $url64

    & 7za x "-o$filePath" -y "$fileFullPath"

    $packageName = 'appleapplicationsupport'
    $file = "$filePath\AppleApplicationSupport.msi"
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

    $processor = Get-WmiObject Win32_Processor
    $is64bit = $processor.AddressWidth -eq 64

    $packageName = 'applemobiledevicesupport'
    if ($is64bit) {$file = "$filePath\AppleMobileDeviceSupport64.msi"} else {$file = "$filePath\AppleMobileDeviceSupport.msi"}
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

    $packageName = 'bonjour'
    if ($is64bit) {$file = "$filePath\Bonjour64.msi"} else {$file = "$filePath\Bonjour.msi"}
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

    $packageName = 'itunes'
    if ($is64bit) {$file = "$filePath\iTunes64.msi"} else {$file = "$filePath\iTunes.msi"}
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
