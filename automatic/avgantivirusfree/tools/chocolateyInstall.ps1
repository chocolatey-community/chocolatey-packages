$packageName = '{{PackageName}}'
$installerType = 'EXE'
$LCID = (Get-Culture).LCID
$SelectedLanguage = "/SelectedLanguage=$LCID"
$silentArgs = '/UILevel=silent /AppMode=setup /InstallToolbar=0 /ChangeBrowserSearchProvider=0 "$SelectedLanguage" /InstallSidebar=0 /ParticipateProductImprovement=0 /DontRestart /DisableScan /KillProcessesIfNeeded'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
	$url = '{{DownloadUrlx64}}'
  } else {
	$url = '{{DownloadUrl}}'
  }
  
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes

#HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AVG
#DisplayVersion 2014.0.4592