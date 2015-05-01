$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
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
  if ($is64bit) {$file = "$filePath\AppleApplicationSupport64.msi"} else {$file = "$filePath\AppleApplicationSupport.msi"}
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64

  $packageName = 'applemobiledevicesupport'
  if ($is64bit) {$file = "$filePath\AppleMobileDeviceSupport6464.msi"} else {$file = "$filePath\AppleMobileDeviceSupport.msi"}
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

  $packageName = 'bonjour'
  if ($is64bit) {$file = "$filePath\Bonjour64.msi"} else {$file = "$filePath\Bonjour.msi"}
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

  $packageName = 'itunes'
  if ($is64bit) {$file = "$filePath\iTunes6464.msi"} else {$file = "$filePath\iTunes.msi"}
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes

}
