$packageName = '{{PackageName}}'
$fileType = 'exe'
$validExitCodes = @(0)
$silentArgs = '-ms'

  $regUninstallDir = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
  $regUninstallDirWow64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'
  
  $uninstallPaths = $(Get-ChildItem $regUninstallDir).Name
  
  if ( Get-ProcessorBits 64 ) {
      if (Test-Path $regUninstallDirWow64) {
        $uninstallPaths += $(Get-ChildItem $regUninstallDirWow64).Name
      }
  }

  $uninstallPath = $uninstallPaths -match
    "Mozilla Firefox [\d\.]+ \([^\s]+ [a-zA-Z\-]+\)" | Select -First 1
  
  $firefox_key = ( $uninstallPath.replace('HKEY_LOCAL_MACHINE\','HKLM:\') )
   	
  $file = (Get-ItemProperty -Path ( $firefox_key ) ).UninstallString 
  
  Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
