$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'


function GetLevel() {

  $CurrentUser = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium'
  $LocalMachine = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium'
  
  if (Test-Path $CurrentUser) {
    $level = ''
  } else {
    $level = '--system-level --do-not-launch-chrome'
  }
  
  return $level
}

function Get-ProcessorBits () {

  $bitness = Get-WmiObject -Class Win32_Processor -ComputerName $env:ComputerName| Select-Object AddressWidth

}


function Get-32bitOnlyInstalled {
  $systemIs64bit = Get-ProcessorBits 64
  
  if (-Not $systemIs64bit) {
    return $false
}

}
  $silentArgs = GetLevel
  
  if ((Get-32bitOnlyInstalled) -or (Get-ProcessorBits 32)) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  } else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
}
